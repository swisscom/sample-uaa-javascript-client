# sample-uaa-javascript-client
Oidc (authorization code with PKCE) sample javascript app 

## Running this sample

Here's how you can run the example app in your own space.

### Clone the repo

Clone this repo.

```
git clone https://github.com/swisscom/sample-uaa-javascript-client.git
```

### Adapt the config

Adapt the `manifest.yml` to include the route which you want to assign, the redirect url and the desired scopes. Note that you will also need to reference this route in the service instance creation step below.

#### ALLOW_PUBLIC:

Here you can set if the client_secret should be used or not in case the service instance provides a client_secret. 
If ALLOW_PUBLIC is set to true, the client_secret will be removed (.profile). See also further below on describing the CREDENTIALS.
Corresponds to the UAA allowpublic feature, see https://docs.cloudfoundry.org/api/uaa/version/76.3.0/index.html#authorization-code-grant-2 


```
---
applications:
  - name: sample-uaa-javascript-client
    memory: 64MB
    routes:
      - route: <provide a route for your app>
    services:
      - oauth2
    env:
      REDIRECT_URI: <your app's route>/callback
      SCOPES: openid, phone
      ALLOW_PUBLIC: true
```

### Create an instance of the UAA service

Use the [Cloud Foundry CLI](https://github.com/cloudfoundry/cli) to create a UAA oauth2 service instance (provider specific) and bind the service instance to the app. The app then selects the first service instance bound to it. VCAP_SERVICES example (extract):

```
CREDENTIALS='{
  "checkTokenEndpoint": "<uaa-url>/check_token",
  "clientId": "SRh5t5De....",
  "introspectEndpoint": "<uaa-url>/introspect",
  "logoutEndpoint": "<uaa-url>/logout.do",
  "authorizationEndpoint": "<uaa-url>/oauth/authorize",
  "redirectUris": "<your app's route>/**",
  "accessTokenValidity": "14400",
  "tokenEndpoint": "<uaa-url>/oauth/token",
  "grantTypes": "refresh_token,authorization_code",
  "scope": "phone,openid,roles,profile,user_attributes,email",
  "clientSecret": "uRM3106A....",
  "userInfoEndpoint": "<uaa-url>/userinfo"
}'
```
#### Info "public" client:

If a service instance with the grant_type "authorization_code" was created with the optional allowpublic parameter then the VCAP_SERVICES/Service-Key (offered from the broker binding) does not offer the client_secret for this client even internally a client_secret has been set.

Such a "public" client has an internal setting and shows an attribute like "allowpublic: true" and allows to omit the client_secret for the PKCE flow.
In this case the removal of an existing client_secret described earlier above with setting the ALLOW_PUBLIC environment variable is not needed.
A "confidential" client (has no allowpublic setting) however cannot omit the client_secret and should not be used for web applications (SPA).   


### Push the app

Push the app to Cloud Foundry

```
cf push
```

## Sample overview

### Authorization code

- Service provider (Spring boot): https://github.com/swisscom/sample-uaa-spring-boot-service-provider
- Service provider (Ruby): https://github.com/swisscom/sample-uaa-ruby-service-provider

### Implicit flow & Client Credentials
> **_WARNING:_** [PKCE's](https://oauth.net/2/pkce/) secure implementation renders the implicit flow obsolete, as it is [vulnerable](https://datatracker.ietf.org/doc/html/draft-ietf-oauth-security-topics#section-2.1.2) and must not be used anymore.
- Client (VueJS): https://github.com/swisscom/sample-uaa-vue-client
- Client (React & Redux):https://github.com/swisscom/sample-uaa-react-redux-client
- Client (AngularJS): https://github.com/swisscom/sample-uaa-angular-client

- Resource Server (Spring boot): https://github.com/swisscom/sample-uaa-spring-boot-resource-server
- Resource Server (Ruby): https://github.com/swisscom/sample-uaa-ruby-resource-server
