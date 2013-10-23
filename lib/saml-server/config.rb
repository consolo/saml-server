module SamlServer
  Config = Struct.new(:service_providers, :users, :auth, :attributes)
  SampleUser = Struct.new(:username, :password)
  SampleSp = Struct.new(:name, :url)

  class << self
    attr_reader :config
  end
  @config = Config.new([], [])

  # The default auth will always return true if there are no users
  self.config.auth = proc do |username, password, request|
    users = SamlServer.config.users
    if users.empty? or users.detect { |user| username && user.username == username && user.password == password }
      SamlServer::Auth.success
    else
      SamlServer::Auth.failure('Password does not match')
    end
  end

  # Returns a Hash of attributes about the user, to be passed along in the SAML response (or nil)
  self.config.attributes = proc do |username|
    nil
  end

  # Add a user and password for SAML authentication
  def self.add_user(username, password)
    self.config.users << SampleUser.new(username, password)
  end

  # Add a service provider to the portal
  def self.add_sp(name, url)
    self.config.service_providers << SampleSp.new(name, url)
  end
end
