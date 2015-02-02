require 'spec_helper'

describe "client" do
  let(:api_user) { "sendgrid_user" }
  let(:api_key) { "password123" }
  let(:client) { SendGridWebApi::Client.new(api_user, api_key) }
  let(:client_invalid) { SendGridWebApi::Client.new("foo", "bar") }

  describe "intialise" do
    it "should return the correct base URL" do
      expect(client.base_url).to eql "https://api.sendgrid.com/api/"
    end

    it "should format the api request" do
      url = client.make_request_url("dummy.url", {foo: "bar"})
      expect(url).to eql "dummy.url?api_key=#{api_key}&api_user=#{api_user}&foo=bar"
    end

    it "should fail with invalid credentials" do
      expect { client_invalid.bounce.get }.to raise_error(AuthenticationError)
    end

    it "shold fail when accessing with invalid method" do
      expect { client.bounce.send(:get_no_found) }.to raise_error(NoMethodError)
    end

  end

  describe "default api calls" do
    [:block, :bounce, :invalid_email, :spam_report].each do |rest_command|

      describe "#{rest_command.to_s}s" do

        it "should not raise error when invalid params" do
          VCR.use_cassette("#{rest_command.to_s}s_list_invalid_params") do
            json = client.bounce.get({invalid_param:"foobar"})
            expect(json.count).to be > 0
          end
        end

        it "should return the list of all #{rest_command.to_s}s" do
          VCR.use_cassette("client_#{rest_command.to_s}s_list") do
            json = client.send(rest_command).get
            expect(json.count).to be > 0
          end
        end

        it "should return a filtered list of #{rest_command.to_s}s" do
          VCR.use_cassette("client_#{rest_command.to_s}s_filter_days") do
            json = client.send(rest_command).get({days:1})
            expect(json.count).to be > 0
          end
        end

        it "should return the count of #{rest_command.to_s}s" do
          VCR.use_cassette("client_#{rest_command.to_s}s_count") do
            json = client.send(rest_command).count
            expect(json["count"]).to be > 0
          end
        end

        it "should delete the #{rest_command.to_s}" do
          VCR.use_cassette("client_#{rest_command.to_s}s_delete") do
            json = client.send(rest_command).delete({email: "user@exists.com"})
            expect(json["message"]).to eql "success"
          end
        end

        it "should not delete the #{rest_command.to_s}" do
          VCR.use_cassette("client_#{rest_command.to_s}s_delete") do
            json = client.send(rest_command).delete({email: "user@notexists.com"})
            expect(json["message"]).to eql "Email does not exist"
          end
        end
      end
    end
  end
end
