# Test SAML IdP and portal

Implements a stripped-down SAML IdP using the Browser SSO Profile (http://en.wikipedia.org/wiki/SAML_2.0#Web_Browser_SSO_Profile, http://saml2int.org/profile/current).

## Powered by ruby-saml-idp

Check out [ruby-saml-idp](https://github.com/lawrencepit/ruby-saml-idp) on Github for more details. Note the [keys and secrets](https://github.com/lawrencepit/ruby-saml-idp/blob/master/README.md#keys-and-secrets).

## Standalone

    [bundle exec] saml-server

See "saml-server --help" for command-line options.

## Embeded

    require 'saml-server'

### Optional config

    # Add some users. If you don't add any, all auth attempts will succeed.
    SamlServer.add_user 'user', 'password'

    # Or replace the entire auth logic block
    SamlServer.config.auth = proc do |username, password, request|
      # return true or false
    end

    # Add some SP endpoints to the portal
    SamlServer.add_sp 'My App', 'http://localhost:3000/login'
