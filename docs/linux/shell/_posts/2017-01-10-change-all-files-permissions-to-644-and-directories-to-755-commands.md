---
description: How to chmod 755 all directories but no files and how to chmod only files but no directories.
layout: post
---

## Overview

There are two common task in Linux environments when handling files
and folders permissions, you often will want to:

- give directories read and write privileges  **(drwxr-xr-x)**
- give files read privileges **(-rw-r--r--)**

This can be done safely with <kbd>find</kbd> and <kbd>chmod</kbd>
commands, taking some precautions.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>chmod --help</kbd>
Usage: chmod [OPTION]... MODE[,MODE]... FILE...
  or:  chmod [OPTION]... OCTAL-MODE FILE...
  or:  chmod [OPTION]... --reference=RFILE FILE...
Change the mode of each FILE to MODE.
With --reference, change the mode of each FILE to that of RFILE.

  -c, --changes          like verbose but report only when a change is made
  -f, --silent, --quiet  suppress most error messages
  -v, --verbose          output a diagnostic for every file processed
      --no-preserve-root  do not treat '/' specially (the default)
      --preserve-root    fail to operate recursively on '/'
      --reference=RFILE  use RFILE's mode instead of MODE values
  -R, --recursive        change files and directories recursively
      --help     display this help and exit
      --version  output version information and exit

Each MODE is of the form '[ugoa]*([-+=]([rwxXst]*|[ugo]))+|[-+=][0-7]+'.
</samp>
</pre>

## Change directory permissions

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>find /path -type d -exec chmod 755 {} +</kbd>
</samp>
</pre>

## Change files permissions

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>find /path -type f -exec chmod 644 {} +</kbd>
</samp>
</pre>

## Run chmod efficiently

To avoid spawning one chmod process per file, we can pipe find output
to <kbd>xargs</kbd>. This can be helpful if there are many files to
process.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>find /path -type d -print0 | xargs -0 chmod 755</kbd>
<span class="shell-prompt">$</span> <kbd>find /path -type f -print0 | xargs -0 chmod 644</kbd>
</samp>
</pre>

> -print0
>      True;  print the full file name on the standard output, followed
>      by a null character (instead of the newline character that -print
>      uses). This allows file names that contain newlines or other
>      types of white space to be correctly interpreted by programs that
>      process the find output. This option corresponds to the -0 option
>      of xargs.
> 
> <footer class="blockquote-footer"> <cite>Find manual page</cite></footer>
{: class="blockquote"}

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>xargs --help</kbd>
Usage: xargs [OPTION]... COMMAND [INITIAL-ARGS]...
Run COMMAND with arguments INITIAL-ARGS and more arguments read from input.

Mandatory and optional arguments to long options are also
mandatory or optional for the corresponding short option.
  -0, --null                   items are separated by a null, not whitespace;
                                 disables quote and backslash processing and
                                 logical EOF processing
..(truncated)
</samp>
</pre>

## References

- Superuser answer to [How to chmod all directories except files (recursively)?](http://superuser.com/a/91938/158197) by [nik](http://superuser.com/users/263/nik)
- StackOverflow: [Using semicolon (;) vs plus (+) with exec in find](http://stackoverflow.com/q/6085156/1165509)
