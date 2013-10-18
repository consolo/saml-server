# encoding: utf-8
require File.join(File.dirname(__FILE__), 'lib', 'saml-server', 'version')

Gem::Specification.new do |spec|
  spec.name = 'saml-server'
  spec.version = SamlServer::VERSION
  spec.summary = "A Ruby SAML IdP Server"
  spec.description = "A SAML IdP Server for Ruby"
  spec.authors = ['Jordan Hollinger']
  spec.date = '2013-10-17'
  spec.email = 'consolohollinger@gmail.com'
  spec.homepage = 'http://github.com/consolo/saml-server'

  spec.require_paths = ['lib']
  spec.files = [Dir.glob('lib/**/*'), 'README.md', 'LICENSE'].flatten
  spec.executables << 'saml-server'

  spec.add_dependency 'sinatra'
  spec.add_dependency 'ruby-saml-idp'
end
