module SendGridWebApi

  class Client
    def bounce
      @bouce ||= Bounce.new(self)
    end
  end

  class Bounce < BaseCommand
  end

end
