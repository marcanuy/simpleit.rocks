---
description: Download an entire website to browse offline with wget in Linux.

---

## Overview

To download an entire website from Linux it is often recommended to
use `wget`, however, it must be done using the right parameters or the
downloaded website won't be similar to the original one, with probably
relative broken links. This tutorial explores the right combination to
download a website:

- converting relative links to full paths so they can be browsed
  offline.
- preventing requesting too many web pages too fast, overloading the server
  and possibly being blocked from requesting more.
- avoid overwriting or creating duplicates of already downloaded files.
  
## Wget summary

> GNU Wget is a free utility for non-interactive download of files
> from the Web
> 
> <footer class="blockquote-footer"> <cite><a
href="https://www.gnu.org/software/wget/manual/html_node/Overview.html#Overview">wget
manual Overview</a></cite></footer>
{: class="blockquote" cite="https://www.gnu.org/software/wget/manual/html_node/Overview.html#Overview"}

The `wget` command is very popular in Linux and present in most
distributions.

To download an entire website we use the following parameters:

`--wait=2`
: > Wait the specified number of seconds between the retrievals. In
  this case 2 seconds.

`--limit-rate=20K`
: > Limit the download speed to amount bytes per second.

`--recursive`
: > Turn on recursive retrieving. The default maximum depth is 5.
: If the website has more levels than 5, then you can specify it with `--level=depth`

`--page-requisites`
: > download all the files that are necessary to properly display a
given HTML page.
: > This includes such things as inlined images, sounds, and
  referenced stylesheets.
  
`--user-agent=Mozilla``
: > Identify as Mozilla to the HTTP server.

`--no-parent`
: >  Do not ever ascend to the parent directory when retrieving
  recursively.

`--convert-links`
: > After the download is complete, convert the links in the document
  to make them suitable for local viewing.
  
`--adjust-extension`
: > If a file of type application/xhtml+xml or text/html is downloaded
  and the URL does not end with the regexp `\.[Hh][Tt][Mm][Ll]?`, this
  option will cause the suffix .html to be appended to the local
  filename.

`--no-clobber`
: > When running Wget with -r, re-downloading a file will result in
  the new copy simply overwriting the old.  Adding -nc will prevent
  this behavior, instead causing the original version to be preserved
  and any newer copies on the server to be ignored.

Summarizing, these are the needed parameters:

~~~ bash
wget --wait=2 \
	 --limit-rate=20K \
	 --recursive
	 --page-requisites \
	 --user-agent=Mozilla \
	 --no-parent \
	 --convert-links \
	 --adjust-extension \
	 --no-clobber \
	 https://example.com
~~~

Or in one line:

<kbd>wget --wait=2 --limit-rate=20K --recursive --page-requisites --user-agent=Mozilla --no-parent --convert-links --adjust-extension --no-clobber https://example.com</kbd>

## Example

Let's try to download the <https://example.com> website (single page)
to see how verbose is `wget` and how it behaves.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>wget --wait=2
--limit-rate=20K --recursive --page-requisites --user-agent=Mozilla
--no-parent --convert-links --adjust-extension --no-clobber  https://example.com</kbd>
--2017-06-30 19:48:46--  https://example.com/
Resolving example.com (example.com)... 93.184.216.34
Connecting to example.com (example.com)|93.184.216.34|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 1270 (1,2K) [text/html]
Saving to: ‘example.com/index.html’

example.com/index.html            100%[===========================================================>]   1,24K  --.-KB/s    in 0,003s

2017-06-30 19:48:46 (371 KB/s) - ‘example.com/index.html’ saved [1270/1270]

FINISHED --2017-06-30 19:48:46--
Total wall clock time: 0,6s
Downloaded: 1 files, 1,2K in 0,003s (371 KB/s)
Converting links in example.com/index.html... nothing to do.
Converted links in 1 files in 0 seconds.
<span class="shell-prompt">$</span> <kbd>tree example.com/</kbd>
example.com/
└── index.html

0 directories, 1 file

</samp>
</pre>

## Conclusion

`wget` is a fantastic command line tool, it has everything you will
ever need without having to use any other GUI tool, just be sure to
browse its manual for the right parameters you want.

The above parameters combination will make you have a browseable
website locally.

## Reference

- `wget` manual <https://www.gnu.org/software/wget/>
  
  
