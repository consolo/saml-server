require 'zlib'
require 'ruby-saml-idp'
require 'sinatra/base'

module SamlServer
  class App < Sinatra::Base
    use Rack::Session::Cookie, key: 'idp.session'
    enable :inline_templates
    disable :absolute_redirects
    enable :prefixed_redirects

    helpers do
      include SamlIdp::Controller

      def current_user
        session[:username]
      end
    end

    before '/' do
      redirect '/login' unless current_user or request.path =~ %r{^/login/?} or request.path =~ %r{^/saml/}
    end

    get '/' do
      erb :index
    end

    get '/login' do
      current_user ? redirect('/') : erb(:login)
    end

    post '/login' do
      if SamlServer.config.auth.(params[:username], params[:password], request)
        session[:username] = params[:username]
        redirect session[:SAMLRequest] ? '/saml' : '/'
      else
        erb :login
      end
    end

    get '/logout' do
      session.clear
      redirect '/login'
    end

    get '/saml' do
      if current_user
        decode_SAMLRequest(params[:SAMLRequest] || session[:SAMLRequest])
        @saml_response = encode_SAMLResponse(current_user)
        erb :saml_response
      else
        session[:SAMLRequest] = params[:SAMLRequest]
        redirect '/login'
      end
    end
  end
end

__END__

@@ index
<h3>Portal</h3>
<p>Welcome, <%= current_user %></p>
<ul>
  <% SamlServer.config.service_providers.each do |sp| %>
    <li><a href="<%= sp.url %>"><%= sp.name %></a></li>
  <% end %>
</ul>
<hr />
<a href="<%= url('/logout') %>">Logout</a>

@@ login
<h3>Login</h3>
<form action="<%= url('/login') %>" method="post">
  <p>
    <label for="username">Email</label>
    <input type="text" id="username" name="username" value="<%= params[:username] %>" autofocus="autofocus" />
  </p>
  <p>
    <label for="password">Password</label>
    <input type="password" id="password" name="password" />
  </p>
  <p><input type="submit" value="Login" /></p>
</form>

@@ saml_response
<form action="<%= @saml_acs_url %>" method="post">
  <input type="hidden" name="SAMLResponse" value="<%= @saml_response %>" />
  <p>You are being signed in. If you are not redirected soon, please click <input type="submit" value="Continue" /></p>
</form>
<script>
  window.onload = function() { document.forms[0].submit() };
</script>

@@ layout
<!doctype html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>Login</title>
  </head>
  <body>
    <%= yield %>
  </body>
</html>
