---
description: A list of tips to secure a Joomla installation
layout: post
tags: joomla
---

## Overview

Tips to prevent your Joomla website from being hacked.

## Security Checklist 

## Upgrade Joomla

Each new Joomla update come with several security patches, not
updating means getting into troubles sooner or later, as new
vulnerabilities are discovered from time to time.

### Avoid old extensions

You should always keep your extensions updated, if you are using an
old extension without support, find an alternative or deactivate it.


### Adjust files and directories permissions

[Change all files permissions to 644 and directories to 755]({% link docs/php/joomla/_posts/2017-01-10-change-all-files-permissions-to-644-and-directories-to-755-commands.md %}).

Files owner should be your user so you can edit them, while your group
(with lesser rights) should be the web server. 

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>chown -R user:www-data /var/www/joomla-dir</kbd>
</samp>
</pre>

htaccess
: `.htaccess` and `configuration.php` shouldn't have write permissions, it would leave them vulnerable to attacks.

PHP files
: All the PHP files shouldn't have write permissions.

### Fix images folder allowed files

The images folder should only contains **images**, it should [block
users from trying to upload every other type of file]({% link docs/php/joomla/_posts/2017-01-09-securing-the-images-folder-in-joomla.md %}),
specially *scripts*.

### Popular extensions

Not try new extensions until they are well tested or popular in the
Joomla community.

## Administrator area with HTTP basic auth

Protect the Administrator area, usually the `/administrator` path,
with
[HTTP Basic Authentication]({% link docs/web/servers/apache/_posts/2017-01-07-protect-web-directories-with-http-basic-authentication-in-apache-server.md %}).

**Useful to
  prevent
  [dictionary attacks](https://en.wikipedia.org/wiki/Dictionary_attack) in
  the Joomla Administrator area.**
  
## Related

After having a secure website it is worth
reading
[How to find Malware and hacked files on a Joomla Site]({% link docs/php/joomla/_posts/2017-01-26-find-out-if-your-joomla-site-has-been-hacked.md %}).
