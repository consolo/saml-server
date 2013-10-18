# Test SAML IdP and portal

Implements a stripped-down SAML IdP using the Browser SSO Profile (http://en.wikipedia.org/wiki/SAML_2.0#Web_Browser_SSO_Profile, http://saml2int.org/profile/current).

## Powered by ruby-saml-idp

Check out [ruby-saml-idp](https://github.com/lawrencepit/ruby-saml-idp) on Github for more details. Note the [keys and secrets](https://github.com/lawrencepit/ruby-saml-idp/blob/master/README.md#keys-and-secrets).

## Standalone

    [bundle exec] samlize

See "samlize --help" for command-line options.

## Embeded

    require 'samlize'

### Optional config

    # Add some users. If you don't add any, all auth attempts will succeed.
    Samlize.add_user 'user', 'password'

    # Or replace the entire auth logic block
    Samlize.config.auth = proc do |username, password|
      # return true or false
    end

    # Add some SP endpoints to the portal
    Samlize.add_sp 'My App', 'http://localhost:3000/login'
