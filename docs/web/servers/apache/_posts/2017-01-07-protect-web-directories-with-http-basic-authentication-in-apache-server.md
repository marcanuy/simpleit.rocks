---
subtitle: Using httpasswd.
description: How to set up a web directory protected with user and password using HTTP basic authentication
layout: post
---

## Overview

HTTP Basic Auth is very common in the web, although it is not the most
secure one. 

It's simplicity makes it a simple choice to add a layer of security to
web directory quickly, not needing *sessions* nor *cookies*.

## Concepts

HTTP Basic authentication needs that a client provides a username
and password when making a request.

> The "Basic" Hypertext Transfer Protocol (HTTP)
> authentication scheme, transmits credentials as user-id/password
> pairs, encoded using Base64
> <footer class="blockquote-footer"> The 'Basic' HTTP Authentication Scheme in <cite><a href="https://tools.ietf.org/html/rfc7617">RFC 7617</a></cite></footer>
{: class="blockquote" cite="https://tools.ietf.org/html/rfc7617"}

## Steps to secure a directory

To use HTTP Basic Authentication on a server, you need to create two files
 
- `.htaccess`: specifies which directory to protect
- `.htpasswd`: passwords file

The each time you access the directory of `.htaccess` it asks for
*username* and *password* validating it against `.htpasswd`
credentials.

We will end up having this directories structure:

~~~
/home
	/secure
		/apasswords
...
/var
	/www
		/myprotected
			.htaccess
~~~

### Create Apache .htaccess

Add an `.htaccess` file inside each directory that will be protected
with the following content, in this case in `/var/www/myprotected/.htaccess`:

~~~
AuthType Basic
AuthName "Restricted Access"
AuthUserFile /home/secure/apasswords
Require valid-user
~~~

### Passwords file

We use the `htpasswd` command to manage user files for basic
authentication.

Command overview:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>htpasswd --help</kbd>
Usage:
	htpasswd [-cimBdpsDv] [-C cost] passwordfile username
	htpasswd -b[cmBdpsDv] [-C cost] passwordfile username password

	htpasswd -n[imBdps] [-C cost] username
	htpasswd -nb[mBdps] [-C cost] username password
 -c  Create a new file.
 -n  Don't update file; display results on stdout.
 -b  Use the password from the command line rather than prompting for it.
 -i  Read password from stdin without verification (for script usage).
 -m  Force MD5 encryption of the password (default).
 -B  Force bcrypt encryption of the password (very secure).
 -C  Set the computing time used for the bcrypt algorithm
     (higher is more secure but slower, default: 5, valid: 4 to 31).
 -d  Force CRYPT encryption of the password (8 chars max, insecure).
 -s  Force SHA encryption of the password (insecure).
 -p  Do not encrypt the password (plaintext, insecure).
 -D  Delete the specified user.
 -v  Verify password for the specified user.
On other systems than Windows and NetWare the '-p' flag will probably not work.
The SHA algorithm does not use a salt and is less secure than the MD5 algorithm.
</samp>
</pre>

#### Create passwords file

Create a directory **outside apache document root**, only Apache should
access the password file.

Using the `htpasswd -c` creates the *passwdfile*.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>mkdir -p /home/secure/</kbd>
<span class="shell-prompt">$</span> <kbd>chmod 0660 /home/secure/apasswords</kbd>
<span class="shell-comment"># Create password file with user foobar</span>
<span class="shell-prompt">$</span> <kbd>htpasswd -c /home/secure/apasswords foobar</kbd>
New password:
Re-type new password:
Adding password for user foobar
<span class="shell-comment"># In this case the server user and group is www-data</span>
<span class="shell-prompt">$</span> <kbd>chown www-data:www-data /home/secure/apasswords</kbd>
</samp>
</pre>

/home/secure/apasswords must be only readable by Apache web server
{: class="alert alert-info"}

The `mkdir -p` creates all the folder structure specified in the
parameters
{: class="alert alert-info"}

#### htpasswd commands

##### To add more users

To change or add more users of the file, the same command can be used
without the `-c` option, to add the user `john`:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>htpasswd .htpasswd john</kbd>
New password:
Re-type new password:
Adding password for user foobar
</samp>
</pre>

#### Changing existing users passwords

We execute the same command with the user that we want to change:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>htpasswd .htpasswd john </kbd>
New password:
Re-type new password:
Updating password for user foobar
</samp>
</pre>

## Risks

The HTTP Basic authentication has several issues that makes it
insecure in some scenarios, the standard itself states:

> This scheme is not considered to be a secure method of user
> authentication unless used in conjunction with some external secure
> system such as TLS (Transport Layer Security, [RFC5246]), as the
> user-id and password are passed over the network as cleartext.
> <footer class="blockquote-footer"> The 'Basic' HTTP Authentication Scheme in <cite><a href="https://tools.ietf.org/html/rfc7617">RFC 7617</a></cite></footer>
{: class="blockquote" cite="https://tools.ietf.org/html/rfc7617"}

|------------------------+-------------------------------------------------------------|
| HTTP Basic auth issue  | Insecurity issue                                            |
|:----------------------:|:-----------------------------------------------------------:|
| Password is sent in base64 encoding | Password can be converted to plaintext *(solved by using [Secure Sockets Layer])* |
| Password is sent for each request   | Larger attack window |
| The password is cached by the webbrowser | Can be reused by any other request to the server, e.g. [CSRF] |
| The password may be stored permanently in the browser | [CSRF] and it might be stolen by another user on a shared machine |

  
  
## References

- RFC 7617 'Basic' HTTP Authentication Scheme <https://tools.ietf.org/html/rfc7617>
- Information Security Answer: [Is BASIC-Auth secure if done over HTTPS?](http://security.stackexchange.com/a/990/66281) by [AviD♦](http://security.stackexchange.com/users/33/avid)
- <https://en.wikipedia.org/wiki/Basic_access_authentication>

[SSL]: https://en.wikipedia.org/wiki/SSL
[CSRF]: https://www.owasp.org/index.php/Cross-Site_Request_Forgery_(CSRF)
