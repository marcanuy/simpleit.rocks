---
description: The images folder is one of the major security risks in Joomla, learn how to prevent being hacked through it.
layout: post
tags: joomla, images, htaccess
---

## Overview

The images folder is one the most vulnerable Joomla folders, because it allows
users to upload files to your website. That could lead to serious
security problems. The file types allowed to upload should be
restricted to its minimum.

We will use `.htaccess` to use several strategies to address this
problem.

`.htaccess` are simply distributed configuration files, they "provide
a way to make configuration changes on a per-directory basis".

In the images folder we can:

- Disable script execution
- Select which files you can upload to it
- Select which files you can NOT upload to it

## Strategies

### Disable script execution in images folder

By default Joomla images directory is located in the `/images` folder,
in this directory we add `.htaccess` with the following content:

~~~
AddHandler cgi-script .php .pl .py .jsp .asp .htm .shtml .sh .cgi
Options -ExecCGI
~~~

We used
the Apache [Options Directive](http://httpd.apache.org/docs/current/mod/core.html#options) and [AddHandler Directive](http://httpd.apache.org/docs/current/mod/mod_mime.html#addhandler):

First we tell Apache to treat the files ending with the above
extensions as CGI scripts, i.e.: be served by [mod_cgi](http://httpd.apache.org/docs/current/mod/mod_cgi.html) handler, then we prevent the execution of those CGI
scripts.

> The Options directive controls which server features are available
> in a particular directory.
> 
> <footer class="blockquote-footer"> <cite>Options Directive in <a href="http://httpd.apache.org/docs/current/mod/core.html#options">Apache Core Features Manual</a></cite></footer>
{: class="blockquote" cite="http://httpd.apache.org/docs/current/mod/core.html#options"}


### .htaccess whitelist

We can specify which file types we allow users to upload to the
`images` folder:

~~~
<FilesMatch ".+\.(gif|jpe?g|png|pdf)$">
Allow from all
</FilesMatch>
~~~

That will allow the above filenames extensions and **block** every
other extension from getting into the folder.

> The <FilesMatch> directive limits the scope of the enclosed
> directives by filename, just as the <Files> directive does. However,
> it accepts a regular expression
> 
> <footer class="blockquote-footer"> <cite><FilesMatch> Directive in <a href="https://httpd.apache.org/docs/2.4/mod/core.html#filesmatch">Apache docs</a></cite></footer>
{: class="blockquote" cite="https://httpd.apache.org/docs/2.4/mod/core.html#filesmatch"}


### .htaccess blacklist

Instead of specifying which files we allow to upload, here we tell
Apache to deny the upload of files with these extensions:

~~~
<FilesMatch "\.(asp|sh|php|php5|pl)$">
Deny from all
</FilesMatch>
~~~

## Conclusion

I found a good strategy to always **disable script execution** and
then also select from one of the other two methods, `.htaccess` **whitelist** or
**blacklist**, so if the attacker even handle to upload the file it won't
get their scripts executed.
	
## References

- Apache docs <http://httpd.apache.org/docs/current>
- Apache HTTP Server Tutorial: .htaccess files <http://httpd.apache.org/docs/current/howto/htaccess.html>
- Apache FilesMatch Directive <https://httpd.apache.org/docs/2.4/mod/core.html#filesmatch>
- Security Checklist/You have been hacked or defaced <https://docs.joomla.org/Security_Checklist/You_have_been_hacked_or_defaced>

*[CGI]: Common Gateway Interface
