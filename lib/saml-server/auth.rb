module SamlServer
  class Auth
    attr_reader :success, :messages

    def self.success
      new(true)
    end

    def self.failure(*errors)
      new(false, errors)
    end

    def initialize(success, messages = nil)
      @success = success
      @messages = messages || []
    end

    def success?
      success == true
    end

    def failure?
      success == false
    end
  end
end
