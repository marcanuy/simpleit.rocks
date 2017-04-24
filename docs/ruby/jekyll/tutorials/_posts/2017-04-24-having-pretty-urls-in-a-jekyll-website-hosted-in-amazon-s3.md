---
description: Deploy a Jekyll website to Amazon S3 having its URLs without extensions (.html)
---

## Overview

One of the problems in having pretty URLs when hosting a Jekyll site
in Amazon S3, is that even we set `permalinks` URLs without `.html`
extensions, the files generated by Jekyll include this extension.

It relies on the server configuration to be able to handle URLs that
does not include the `.html` extension, to understand them and serve
the corresponding file.

Amazon S3 isn't able to make this translation, so it leaves us with
two options to have URLs without ending in `.html`:

- Create each post in Jekyll as a `(directory)/index.html` file, so it
  will serve each `index.html`. E.g.:
  
	We try to access `https://example.com/my-cool-page`, then Amazon S3
    server will be able to respond to this request if it finds one of
    these files:
	
	    /my-cool-page/index.html
	
Or
	
- Generate HTML files without the extension: `/my-cool-page`

Content-type header of extension-less files will be automatically set
to `text/html`
{.alert .alert-info}

## Remove extension from files before deploying

If configuring Jekyll to generate posts/pages in subdirectories is not
an option, then we can remove the `.html` extension to all the files,
**except** those named `index.html`, just before deploying them
to the server.

An easy way to do it is to have a shell script that removes them after
building the site.

~~~ bash
find _site/ -type f -name '*.html' -print0 | while read -d $'\0' f; do mv "$f" "${f%.html}"; done
~~~

Command explanation:

<dl class="row"> 
<dt class="col-sm-3">-type f</dt> 
<dd class="col-sm-9">
File is of type "regular file"
</dd> 
<dt class="col-sm-3">-name pattern</dt> 
<dd class="col-sm-9">
<blockquote>Base of file name (the path with the leading directories removed) matches shell pattern pattern.</blockquote>
</dd> 
<dt class="col-sm-3">-print0</dt> 
<dd class="col-sm-9">
<blockquote>True;  print the full file name on the standard output, followed by a
null character (instead of the newline character that -print uses).
This allows file names that contain newlines or other types of white
space to be correctly interpreted by programs that process the find
output. This option corresponds to the -0 option of xargs.</blockquote>
</dd> 
<dt class="col-sm-3">read -d delimiter</dt> 
<dd class="col-sm-9">
<blockquote>The first character of DELIM is used to terminate the input line, rather than newline.</blockquote>
</dd> 
</dl>


Example:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>jekyll build</kbd>
Configuration file: /tmp/j/_config.yml
            Source: /tmp/j
       Destination: /tmp/j/_site
 Incremental build: disabled. Enable with --incremental
      Generating... 
                    done in 1.433 seconds.
<span class="shell-prompt">$</span> <kbd>tree _site/</kbd>
_site/
|-- about
|   `-- index.html
|-- assets
|   `-- main.css
|-- feed.xml
|-- index.html
`-- jekyll
    `-- update
        `-- 2017
            `-- 04
                `-- 24
                    `-- welcome-to-jekyll.html

7 directories, 5 files
<span class="shell-prompt">$</span> <kbd>find _site/ -type f -name '*.html' -print0 | while read -d $'\0' f; do mv "$f" "${f%.html}"; done</kbd>
<span class="shell-prompt">$</span> <kbd>tree _site/</kbd>
_site/
|-- about
|   `-- index
|-- assets
|   `-- main.css
|-- feed.xml
|-- index
`-- jekyll
    `-- update
        `-- 2017
            `-- 04
                `-- 24
                    `-- welcome-to-jekyll

7 directories, 5 files
</samp>
</pre>

Then we can safely upload the `_site` folder to the S3 bucket and all
the URL that does not have extensions will work.

## References

- Index documents in
  S3
  <http://docs.aws.amazon.com/AmazonS3/latest/dev/IndexDocumentSupport.html>
- Caching user input in bash <http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_08_02.html>
- [thkala](http://stackoverflow.com/users/507519/thkala) answer in [Linux: remove file extensions for multiple files](http://stackoverflow.com/a/4509530/1165509)