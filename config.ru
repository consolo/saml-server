$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')

require 'saml-server'

run SamlServer::App
