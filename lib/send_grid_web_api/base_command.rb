module SendGridWebApi

  class BaseCommand
    ENDPOINTS = [:get, :delete, :count]
    attr_accessor :format
    attr_accessor :endpoint
    attr_accessor :client

    def initialize(client)
      @client = client
      self.format = "json"
      self.endpoint = self.class.name.split("::").last.downcase + "s"
    end

    def method_missing(method, *args, &block)
      if ENDPOINTS.include?(method)
        options = args.empty? ? {} : args.first
        self.client.query_get_api("#{self.endpoint}.#{method}.#{format}", options)
      else
        super
      end
    end

  end

end
