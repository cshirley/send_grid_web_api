module SendGridWebApi

  class Client
    def spam_report
      @block ||= SpamReport.new(self)
    end
  end

  class SpamReport < BaseCommand
  end

end
