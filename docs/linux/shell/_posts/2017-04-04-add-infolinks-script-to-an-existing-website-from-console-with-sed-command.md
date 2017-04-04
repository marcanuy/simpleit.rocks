---
description: How to integrate infolinks on your website with a simple shell command. Add the infolinks script to all webpages with SED.
---

## Overview

An easy way to monetize your blog content is to add the [Infolinks]
script to the website. This is a simple guide to add this script with
a shell command to all the web pages of a static site.

## How infolinks work

To integrate [Infolinks] in your website, you need to add a script to
each web page and it will convert some of the posts words into links
to monetize them through automated affiliate links.

## The command

After [registering](http://www.infolinks.com/join-us?aid=2980966) the
script can be obtained
at <https://publishers.infolinks.com/members/1-minute-integration>.


<img class="img-fluid" alt="infolinks script" src="https://s3.amazonaws.com/simpleitrocksbucket/images/infolinksscript.png" />

The script should be placed in each webpage before the closing
`</body>` HTML tag.

For this we will use the **sed** command, its name stands for
**S**tream **Ed**itor and is used to perform basic text
transformations on files.

### Put script in a file

Create a file named `changes.sed` with the basic changes for the *sed*
command:

~~~ shell
# insert the closing div tag *before* the closing body tag
/<\/body>/i\
~~~

Then copy the infolinks script in the same file adding a backslash `\`
after each line, so `changes.sed` will look like:

~~~ shell
# insert the closing div tag *before* the closing body tag
/<\/body>/i\
<script type="text/javascript">\
var infolinks_pid = 2980966;\
var infolinks_wsid = 0;\
</script>\
<script type="text/javascript" src="//resources.infolinks.com/js/infolinks_main.js"></script>
~~~

This will tell *sed* to insert the javascript code before the
`</body>` HTML tag.

We will use this file as the script to be inserted by *sed* with the
parameter `-f`:

> -f script-file
> --file=script-file
>
>    Add the commands contained in the file script-file to the set of commands to be run while processing the input.

### Transform all files

Go to the directory you have all the web pages and test the command
with one page:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>sed -f changes.sed < webpage.html | less</kbd>
</samp>
</pre>

Then apply the changes to each file **replacing the original
content**.

Having a backup of the site before applying the changes is always a
good practice.
{: .alert .alert-danger}

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>find . -type f -exec sed -i -f changes.sed {} \;</kbd>
</samp>
</pre>

The `-i` *sed* parameter stands for **in place** so it will replace each file contents.

## Conclusion

This is a simple way for monetizing web content without having to deal
with complex configurations or having to alter web content in any
way. It integrates seamlessly into each web page and starts making a
revenue from it.


## References

- *sed* manual at
  *gnu* <https://www.gnu.org/software/sed/manual/sed.html>

[Infolinks]: http://www.infolinks.com/join-us?aid=2980966
