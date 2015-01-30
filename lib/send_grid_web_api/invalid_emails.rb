module SendGridWebApi

  class Client
    def invalid_email
      @block ||= InvalidEmail.new(self)
    end
  end

  class InvalidEmail < BaseCommand
  end

end
