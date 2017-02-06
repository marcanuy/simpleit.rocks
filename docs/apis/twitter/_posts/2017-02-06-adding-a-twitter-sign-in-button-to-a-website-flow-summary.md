---
description: A summary of the process to add a sign in button to a website.
---

## Overview

Twitter uses [OAuth](https://oauth.net/), an open protocol to allow secure authorization in
a standard method from applications, to provide authorized access to its API.

This is a summary of the process described in <https://dev.twitter.com/oauth>

## Twitter oauth

[Twitter](https://dev.twitter.com/oauth)
uses [OAuth](https://oauth.net/) 1.0A so users are not required to
share their passwords with third party applications.

In OAuth 1.0A there are two forms of authentication:

- User authentication
  - is a form of authentication where your application makes API requests on end-users behalf
- Application-only authentication
  - is a form of authentication where your application makes API requests on its own behalf

> To make authorized calls to Twitter’s APIs, your application must
> first obtain an OAuth access token on behalf of a Twitter user (or,
> you could issue Application-only authenticated requests, when user
> context is not required).

To have a [sign-in button](https://dev.twitter.com/web/sign-in/implementing) tokens are obtained like this:

1. Obtain a **request token** (`oauth_token` and `oauth_token_secret`)
   also sending an `oauth_callback`
   - obtain a **request token** by sending a signed message
     to
     [https://api.twitter.com/oauth/request_token](https://api.twitter.com/oauth/request_token) with
     an `oauth_callback` parameter indicating where the user will be
     redirected in *Step 2*.
   - Check that the HTTP status of the response is 200 (success)
   - parameters returned:
	 - `oauth_token` (store for next step)
	 - `oauth_token_secret` (store for next step)
	 - `oauth_callback_confirmed` (verify it is true)
2. Redirect the user to Twitter including the `oauth_token`.
   - We need to direct the user to Twitter to complete sign in.
   - Redirect user with a GET
     to
     [https://api.twitter.com/oauth/authenticate](https://dev.twitter.com/oauth/reference/get/oauth/authenticate)
	 including the `oauth_token` parameter from *Step 1*. (Probably
     an HTTP 302 redirect)
	 - `GET oauth Authenticate` method differs from `GET oauth / authorize`
	   in that if the user has already granted the application
	   permission, the redirect will occur without the user having to
	   re-approve the application.
       - **To realize this behavior, you must enable the Use Sign in
		 with Twitter setting on your application record.** 
		 - `Allow this application to be used to Sign in with Twitter`
           checkbox
	 - The sign in endpoint can behave in three different ways
       depending on this status:
	   - **Signed in and approved**
		 - If the user:
		   - is signed in on twitter.com and
		   - has already approved the calling application
		 - then they will be immediately authenticated and returned to
           the callback URL with a valid OAuth *request token*
	   - **Signed in but not approved**
		 -  If the user:
			- is signed in to twitter.com **but**
			- has not approved the calling application
		 - then:
		   - a request to share access with the calling application
		   will be shown
		   - After accepting the authorization request
			 - the user will be redirected to the callback URL with a
               valid OAuth *request token*
	   - **Not signed in**
		 - If the user is not signed in on twitter.com
		 - then they will be prompted
		   - to enter their credentials and 
		   - grant access for the application to access their
		   information on the same screen. 
		 - Once signed in, 
		   - the user will be returned to the callback URL with a
             valid OAuth *request token*.
	 - Upon a successful authentication, your **callback_url** would
	 receive a request containing
		 - `oauth_token` and
		 - `oauth_verifier `
3. Convert the request token to an access token (Upgrade request token)
   - To render the **request token** into a usable **access token**:
	 - your application must make a request to the `POST oauth /
       access_token`
       endpoint
       [https://api.twitter.com/oauth/access_token](https://dev.twitter.com/oauth/reference/post/oauth/access_token),
       containing the `oauth_verifier` value obtained in step 2
	 - Twitter generates the **access token**
	 - Twitter response with
	   - `oauth_token`
	   - `oauth_token_secret`
	   - `user_id`
	   - `screen_name`
   - **The `token` and `token secret` should be stored and used for future authenticated requests to the Twitter API.**

## References

- <https://oauth.net/>
- <https://dev.twitter.com/oauth/overview/faq>
