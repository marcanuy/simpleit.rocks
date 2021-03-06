---
title: Host a Jekyll Website With Pretty Urls In Amazon S3 and Cloudfront
description: How to host and deploy a Jekyll website to AWS S3 having its URLs without extensions (.html)
---

## Overview

One of the problems in having pretty URLs when hosting a Jekyll site
in Amazon S3, is that even we set `permalinks` URLs without `.html`
extensions, the files generated by Jekyll include this extension.

It relies on the server configuration to be able to detect its
content-type[^contenttype] so it can handle URLs that does not include the `.html`
extension, and serve the corresponding file.

Amazon S3 isn't able to make this translation, so it leaves us with
two options to have URLs without ending in `.html`:

- Create each post in Jekyll as a `(directory)/index.html` file, so it
  will serve each `index.html`. E.g.:
  
	We try to access `https://example.com/my-cool-page`, then Amazon S3
    server will be able to respond to this request if it finds one of
    these files:
	
	    /my-cool-page/index.html
	
Or
	
- Generate HTML files without the extension: 

        /my-cool-page

Also, the **Content-type** header of extension-less files should be
set to `text/html` after renaming them.

## Remove extension from files before deploying

If configuring Jekyll to generate posts/pages in subdirectories is not
an option, then we can remove the `.html` extension to all the files,
**except** those named `index.html`, just before deploying them
to the server.

An easy way to do it is to have a shell script that removes them after
building the site.

~~~ bash
find _site/ -type f ! -iname 'index.html' -iname '*.html' -print0 | while read -d $'\0' f; do mv "$f" "${f%.html}"; done
~~~

Command explanation:

<dl class="row"> 
<dt class="col-sm-3">-type f</dt> 
<dd class="col-sm-9">
File is of type "regular file"
</dd> 
<dt class="col-sm-3">! -iname 'index.html'</dt> 
<dd class="col-sm-9">
Avoid matching index.html files.
</dd> 
<dt class="col-sm-3">-iname pattern</dt> 
<dd class="col-sm-9">
<blockquote>Base of file name (the path with the leading directories
removed) matches shell pattern pattern.</blockquote> Case insensitive
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
<span class="shell-prompt">$</span> <kbd>find _site/ -type f ! -iname 'index.html' -iname '*.html' -print0 | while read -d $'\0' f; do mv "$f" "${f%.html}"; done</kbd>
<span class="shell-prompt">$</span> <kbd>tree _site/</kbd>
_site/
├── about
│   └── index.html
├── assets
│   └── main.css
├── feed.xml
├── index.html
└── jekyll
    └── update
        └── 2017
            └── 04
                └── 26
                    └── welcome-to-jekyll

7 directories, 5 files
</samp>
</pre>

## Upload files

When uploading the files to the server we must set the correct MIME
type to `Content-Type: text/html` to the files that does not have
`.html` extension, if we don't set them, then the server will
interpret them as `Content-Type: binary/octet-stream`. Other files
will get the correct *Content-Type*.

The
[Amazon S3 Command Line Interface](http://docs.aws.amazon.com/cli/latest/reference/s3/) has
a special parameter to set the correct *Content-Type* for each file
when
[copying](http://docs.aws.amazon.com/cli/latest/reference/s3/cp.html)
them: <kbd>aws s3 cp local_directory bucket-name --content-type
text/html</kbd>

In this approach, we are going to copy the files without extension,
setting the right *Content-Type*, and then just copy the rest of the
files, leaving that task to the server.

### Copy files without extension

Copy local files to the S3 bucket.

~~~ bash
aws s3 cp _site/ s3://cachedpage.co/ --content-type text/html --recursive --exclude "*.*"
~~~

or synchronize the directory with the S3 bucket **checking file
difference by size** not timestamps.

~~~ bash
aws s3 sync _site/ $s3_bucket --size-only --exclude "*" --include "*.*" --delete
~~~

As every time the website is built, Jekyll regenerates all the files,
so *timestamps* would always be different, checking file sizes would
only copy files if they are different.
{: .alert .alert-info }

### Copy the rest of the files

~~~ bash
aws s3 cp _site/ s3://cachedpage.co/ --recursive --exclude "*" --include "*.*"
~~~

or with <kbd>aws sync</kbd>:

~~~ bash
aws s3 sync _site/ $s3_bucket --size-only --content-type text/html --exclude "*.*" --delete
~~~

> Note that, by default, all files are included. This means that
> providing only an --include filter will not change what files are
> transferred. --include will only re-include files that have been
> excluded from an --exclude filter. If you only want to upload files
> with a particular extension, you need to first exclude all files,
> then re-include the files with the particular extension.
> 
> <footer class="blockquote-footer"> <cite><a href="http://docs.aws.amazon.com/cli/latest/reference/s3/#use-of-exclude-and-include-filters">Use of Exclude and Include Filters</a></cite></footer>
{: class="blockquote" cite="http://docs.aws.amazon.com/cli/latest/reference/s3/#use-of-exclude-and-include-filters"}

## Invalidate uploaded files in Cloudfront

If we are using a Content Delivery Network, chances are that your
files has been cached and you need to refresh them. To remove an
object from CloudFront edge caches before it expires we need to
*invalidate* them.

> The next time a viewer requests the object, CloudFront returns to
> the origin to fetch the latest version of the object. 
> 
> <footer class="blockquote-footer"> <cite><a href="http://docs.aws.amazon.com/cli/latest/reference/s3/#use-of-exclude-and-include-filters">Invalidating Objects (Web Distributions Only)</a></cite></footer>
{: class="blockquote" cite="http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Invalidation.html"}

For this we copy the modified file names to a temporal file, and then
create a new **invalidation** with these names as they are access in
our website.

> AWS CLI support for this service is only available in a preview
> stage. You can enable this service by running: `aws configure set
> preview.cloudfront true`
> 
> <footer class="blockquote-footer"> <cite><a href="http://docs.aws.amazon.com/cli/latest/reference/s3/#use-of-exclude-and-include-filters">create-invalidation</a></cite></footer>
{: class="blockquote" cite="http://docs.aws.amazon.com/cli/latest/reference/cloudfront/create-invalidation.html"}

~~~ bash
tempfile=$(mktemp)
distribution_id=ASDFHDFSAF45234
echo "Copying files to server..."
aws s3 sync _site/ $(s3_bucket) --size-only --exclude "*" --include "*.*" --delete | tee -a $(tempfile)
echo "Copying files with content type..."
aws s3 sync _site/ $(s3_bucket) --size-only --content-type text/html --exclude "*.*" --delete | tee -a $(tempfile)
#invalidate only modified files
grep "upload\|deleted" $(tempfile) | sed -e "s|.*upload.*to $(s3_bucket)|/|" | sed -e "s|.*delete: $(s3_bucket)|/|" | sed -e 's/index.html//' | sed -e 's/\(.*\).html/\1/' | tr '\n' ' ' | xargs aws cloudfront create-invalidation --distribution-id $(distribution_id) --paths
~~~

### Script explanation:

First we create the temporal file that will hold modified files with
`tempfile=$(mktemp)`.

Then we synchronize the local directory with the remote one in S3,
redirecting the output to standard output and to the temporal file
with:

    aws s3 sync _site/ $(s3_bucket) --size-only --exclude "*" --include "*.*" --delete | tee -a $(tempfile)
	aws s3 sync _site/ $(s3_bucket) --size-only --content-type text/html --exclude "*.*" --delete | tee -a $(tempfile)

After that we process the file names that were uploaded or deleted by
the `aws` command: 

	grep "upload\|deleted" $(tempfile) 

Then discard the string between `upload` or `delete` and the name of
the bucket:

    sed -e "s|.*upload.*to $(s3_bucket)|/|" | sed -e "s|.*delete:
	$(s3_bucket)|/|" 

As our URLs are accessed only with the URLs like `/` instead of
`/index.html` we remove them

    sed -e 's/index.html//' 
	
Our URLs doesn't have the `.html` extension also:

	sed -e 's/\(.*\).html/\1/' 
	
Lastly we put all the URLs like names in a single line separated with 
a space to comply with the `aws cloudfront create-invalidation
--paths` command:

	tr '\n' ' ' | xargs aws cloudfront create-invalidation --distribution-id $(distribution_id) --paths

## Final script

The complete process is reflected in the following `deploy.sh` script,
you probably want to adapt it to a `Makefile`, `Grunt` or some other
program but I will leave it as a `bash` script to reflect its usage:

~~~ bash
#!/usr/bin/env bash
#
# Copy Jekyll site to S3 bucket
#
####################################
#
# Custom vars
#
s3_bucket="s3://example.com/"
distribution_id=ASDFHDFSAF45234
####################################

set -e # halt script on error
set -v # echo on

tempfile=$(mktemp)

echo "Building site..."
JEKYLL_ENV=production bundle exec jekyll build

echo "Removing .html extension"
find _site/ -type f ! -iname 'index.html' -iname '*.html' -print0 | while read -d $'\0' f; do mv "$f" "${f%.html}"; done

echo "Copying files to server..."
aws s3 sync _site/ $(s3_bucket) --size-only --exclude "*" --include "*.*" --delete | tee -a $(tempfile)
echo "Copying files with content type..."
aws s3 sync _site/ $(s3_bucket) --size-only --content-type text/html --exclude "*.*" --delete | tee -a $(tempfile)
#invalidate only modified files
grep "upload\|deleted" $(tempfile) | sed -e "s|.*upload.*to $(s3_bucket)|/|" | sed -e "s|.*delete: $(s3_bucket)|/|" | sed -e 's/index.html//' | sed -e 's/\(.*\).html/\1/' | tr '\n' ' ' | xargs aws cloudfront create-invalidation --distribution-id $(distribution_id) --paths
~~~

## Conclusion

This approach will work in most situations, you have to be careful if
you have any other files without extension to avoid setting the wrong
media type.

## References

- Index documents in
  S3
  <http://docs.aws.amazon.com/AmazonS3/latest/dev/IndexDocumentSupport.html>
- Caching user input in bash <http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_08_02.html>
- [thkala](http://stackoverflow.com/users/507519/thkala) answer in [Linux: remove file extensions for multiple files](http://stackoverflow.com/a/4509530/1165509)
- S3 cli docs <http://docs.aws.amazon.com/cli/latest/reference/s3/>
- S3 Exclude and include
  filters
  <http://docs.aws.amazon.com/cli/latest/reference/s3/index.html#use-of-exclude-and-include-filters>
- Complete list of MIME
  types
  <https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Complete_list_of_MIME_types>
- Content Type Header field <https://www.w3.org/Protocols/rfc1341/4_Content-Type.html>
- MIME media type name : Text <https://www.iana.org/assignments/media-types/text/html>

[^contenttype]:
	The Content-Type entity header is used to indicate the media type
    of the resource, a string sent in the headers of a file to
    indicate its type
	
	> The purpose of the Content-Type field is to describe the data
	> contained in the body fully enough that the receiving user agent
	> can pick an appropriate agent or mechanism to present the data
	> to the user, or otherwise deal with the data in an appropriate
	> manner. 
	> 
	> <footer class="blockquote-footer"> <cite><a
	> href="https://www.w3.org/Protocols/rfc1341/4_Content-Type.html">The content type header field</a></cite></footer>
	{: class="blockquote" cite="https://www.w3.org/Protocols/rfc1341/4_Content-Type.html"}
