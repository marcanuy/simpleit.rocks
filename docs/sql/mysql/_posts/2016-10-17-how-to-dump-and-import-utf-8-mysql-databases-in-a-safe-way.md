---
---

# Overview

If you have a MySQL database with its character set encoded in
[UTF-8](https://en.wikipedia.org/wiki/UTF-8), then you need to treat it
in a special way when dumping and restoring the database to be able to
read its special characters.

# Dumping a database

The common and quickest way of dumping a database with `mysqldump` does not
treat _utf-8_ encoding right.

Avoid doing it like: 

<div class="alert alert-danger" role="alert">
	mysqldump -uroot -p database > utf8.dump
</div>

This is the correct way to dump a MySQL database safely:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>mysqldump -uroot -p database -r utf8.dump</kbd>
...
</samp>
</pre>

The `-r` or, the same,`--result-file` option, will create the output in ASCII format.

>  --result-file=file_name, -r file_name
>
>           Direct output to the named file. The result file is created and its previous contents overwritten, even if an error
>           occurs while generating the dump.
>
>           This option should be used on Windows to prevent newline “\n” characters from being converted to “\r\n” carriage
>           return/newline sequences.
> <footer class="blockquote-footer"> <cite>MySQL 5.7 <a href="http://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_result-file">Reference Manual</a></cite></footer>
{: class="blockquote" cite="http://dev.mysql.com/doc/refman/5.7/en/mysqldump.html#option_mysqldump_result-file"}


# Restoring a database

Usually you will restore a database simply inserting the data with an input
file descriptor `<`, but this won't handle `utf-8` encoding properly, so
this should be avoided:

<div class="alert alert-danger" role="alert">
mysql -u username -p database < dump_file
</div>

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>mysql -uroot -p --default-character-set=utf8 database</kbd>
<span class="shell-prompt">mysql> </span> <kbd>SET names 'utf8'</kbd>
<span class="shell-prompt">mysql> </span> <kbd>SOURCE utf8.dump</kbd>
...
</samp>
</pre>

# Related Definitions

## Character set

> A character set is a set of symbols and encodings. A collation is a set 
> of rules for comparing characters in a character set. Let's make the
> distinction clear with an example of an imaginary character set.
> Suppose that we have an alphabet with four letters: A, B, a, b. We give
> each letter a number: A = 0, B = 1, a = 2, b = 3. The letter A is a 
> symbol, the number 0 is the encoding for A, and the combination of all
> four letters and their encodings is a character set. 
> <footer class="blockquote-footer">Character Sets and Collations in General <cite title="MySQL Docs">MySQL Docs</cite></footer>
{: class="blockquote" cite="http://dev.mysql.com/doc/refman/5.7/en/charset-general.html"}

## UTF-8

> UTF-8 (Unicode Transformation Format with 8-bit units) is an alternative 
> way to store Unicode data. It is implemented according to RFC 3629, which
> describes encoding sequences that take from one to four bytes. 
> <footer class="blockquote-footer">The utf8 Character Set (3-Byte UTF-8 Unicode Encoding) <cite title="MySQL Docs">MySQL Docs</cite></footer>
{: class="blockquote" cite="http://dev.mysql.com/doc/refman/5.7/en/charset-unicode-utf8.html"}


Reference 
---------

+ <https://makandracards.com/makandra/595-dumping-and-importing-from-to-mysql-in-an-utf-8-safe-way>
+ Configuring the default database charset <https://dev.mysql.com/doc/refman/5.7/en/charset-applications.html>
