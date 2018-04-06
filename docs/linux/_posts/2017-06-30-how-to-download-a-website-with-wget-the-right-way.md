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
  
## Using Wget

> GNU Wget is a free utility for non-interactive download of files
> from the Web
> 
> <footer class="blockquote-footer"> <cite><a
href="https://www.gnu.org/software/wget/manual/html_node/Overview.html#Overview">wget
manual Overview</a></cite></footer>
{: class="blockquote" cite="https://www.gnu.org/software/wget/manual/html_node/Overview.html#Overview"}

### Wget needed parameters

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

`-e robots=off`
: > turn off the robot exclusion

`--level`
: > Specify recursion maximum depth level depth. Use `inf` as the
  value for inifinite.

### Summary 

Summarizing, these are the needed parameters:

~~~ bash
wget --wait=2 \
     --level=inf \
	 --limit-rate=20K \
	 --recursive
	 --page-requisites \
	 --user-agent=Mozilla \
	 --no-parent \
	 --convert-links \
	 --adjust-extension \
	 --no-clobber \
	 -e robots=off \
	 https://example.com
~~~

Or in one line:

<kbd>wget --wait=2 --level=inf --limit-rate=20K --recursive --page-requisites --user-agent=Mozilla --no-parent --convert-links --adjust-extension --no-clobber -e robots=off https://example.com</kbd>

### Example

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

## Wget mirror

`Wget` already comes with a handy `--mirror` paramater that is the
same to use `-r -l inf -N`. That is:

- recursive download
- with infinite depth
- turn on time-stamping.

## Download all the URLs at website's sitemap

Another approach is to avoid doing a recursive traversal of the
website and download all the URLs present in `sitemap.xml`.

### Filtering url from sitemap

A sitemap file typically has the form:

~~~ xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
<url>
<loc>https://marcanuy.com/en/projects/conversions</loc>
<lastmod>2014-09-15T00:00:00-03:00</lastmod>
</url>
<url>
<loc>https://marcanuy.com/en/projects/games-for-kids</loc>
<lastmod>2014-09-15T00:00:00-03:00</lastmod>
</url>
</urlset>
~~~

We need to get all the URLs present in `sitemap.xml`, using `grep`:
<kbd>grep "<loc>" sitemap.xml</kbd>.

### Removing loc tags

Now to remove the superfluous tags: <kbd>sed -e 's/<[^>]*>//g'`</kbd>

### Putting it all together

After the previous two command we have a list of URLs, and that is the
parameter read by `wget -i`:

<kbd>wget -i `grep "<loc>" sitemap.xml| sed -e 's/<[^>]*>//g'`</kbd>

And wget will start downloading them sequentially.

## Conclusion

`wget` is a fantastic command line tool, it has everything you will
ever need without having to use any other GUI tool, just be sure to
browse its manual for the right parameters you want.

The above parameters combination will make you have a browseable
website locally.

You should be careful to check that `.html` extensions works for your
case, sometimes you may want that wget generates them based on the
Content Type but sometimes you should avoid wget generating them as is
the case when using *pretty urls*.

## Reference

- `wget` manual <https://www.gnu.org/software/wget/>
  
  
