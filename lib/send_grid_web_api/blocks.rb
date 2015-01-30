module SendGridWebApi

  class Client
    def block
      @block ||= Block.new(self)
    end
  end

  class Block < BaseCommand
  end

end
