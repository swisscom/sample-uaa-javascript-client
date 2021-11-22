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

Adapt the `manifest.yml` to include the route which you want to assign, the redirect url and the desired scopes  . Note that you will also need to reference this route in the service instance creation step below.

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
```

### Create an instance of the UAA service

Use the [Cloud Foundry CLI](https://github.com/cloudfoundry/cli) to create a UAA oauth2 service instance (provider specific) and bind the service instance to the app. The app then selects the first service instance bound to it. VCAP_SERVICES Example (extract):

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

- Client (VueJS): https://github.com/swisscom/sample-uaa-vue-client
- Client (React & Redux):https://github.com/swisscom/sample-uaa-react-redux-client
- Client (AngularJS): https://github.com/swisscom/sample-uaa-angular-client

- Resource Server (Spring boot): https://github.com/swisscom/sample-uaa-spring-boot-resource-server
- Resource Server (Ruby): https://github.com/swisscom/sample-uaa-ruby-resource-server
