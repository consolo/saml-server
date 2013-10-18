# A SAML IdP server and portal simulation

A stripped-down SAML IdP server and portal. Implements the Browser SSO Profile (http://en.wikipedia.org/wiki/SAML_2.0#Web_Browser_SSO_Profile, http://saml2int.org/profile/current).

This is not intended to be a production-ready server. Rather, it provides a simulation of same for local development, testing, and proof-of-concept.
Once your app works with this, you should be able to drop in a "real" SAML IdP.

Powered by [ruby-saml-idp](https://github.com/lawrencepit/ruby-saml-idp).

## Standalone

    [bundle exec] saml-server

### Configuration

See "--help".

## Embedded

Simply "require 'saml-server"', then mount SamlServer::App at a suburi with Rack or Rails.

### Configuration

    # Add some users. If you don't add any, all auth attempts will succeed.
    SamlServer.add_user 'user', 'password'

    # Or replace the entire auth logic block
    SamlServer.config.auth = proc do |username, password, request|
      # return true or false
    end

    # Add some SP endpoints to the portal
    SamlServer.add_sp 'My App', 'http://localhost:3000/login'

## SP Configuration

* SSO Target URL: http://<host>[/mount]/saml
* Cert Fingerprint: https://github.com/lawrencepit/ruby-saml-idp/blob/master/README.md#keys-and-secrets
* Name Id Format: urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress
