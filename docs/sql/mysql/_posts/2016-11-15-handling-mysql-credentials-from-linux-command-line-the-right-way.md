---
title: #If title is omitted, Jekyll generates a title based in the slug/filename
subtitle: Hide MySQL user and password from command line
description: > # Under 140 char. Used for meta description and main description
  Guide to use configuration files to handle MySQL user and password
  information so they are never typed in Linux console.
slug: 
layout: post
tags: # one or multiple tags can be added to a post. Also like categories, tags can be specified as a YAML list or a comma-separated string.
- mysql
- bash
- console
---

## Overview

Credentials should never by typed in the command line, it is better to
handle them in configuration files so they are never shown in logs,
processes and you don't need to explicitly type them.

This is specially useful to automate MySQL backups and use it safely
in shared environments like a VPS or any shared hosting.

We use MySQL configuration files to configure credentials as they are
read at the startup stage.

> Option files provide a convenient way to specify commonly used
> options so that they need not be entered on the command line each
> time you run a program. 
> <footer class="blockquote-footer"> <cite>MySQL 5.7 Reference Manual
> in <a href="http://dev.mysql.com/doc/refman/5.7/en/option-files.html">Using Option Files</a></cite></footer>
{: class="blockquote" cite="http://dev.mysql.com/doc/refman/5.7/en/option-files.html"}

Always avoid typing the user and password `$ mysql --host=localhost
--user=myname --password=mypass mydb`
{: class="alert alert-danger"}

## Setting up the credentials file

We create a configuration file `mydb.cnf` with the following format.

~~~
[client]
host=
user=
password=
~~~

## Using the config file

Then we can use the `defaults-extra-file` parameter to tell MySQL to read our configuration.

> --defaults-extra-file=file_name
>
>   Read this option file after the global option file but (on Unix)
>   before the user option file and (on all platforms) before the login
>   path file. (For information about the order in which option files are
>   used, see Section 5.2.6, “Using Option Files”.) If the file does not
>   exist or is otherwise inaccessible, an error occurs. file_name is
>   interpreted relative to the current directory if given as a relative
>   path name rather than a full path name. 
> <footer class="blockquote-footer"> <cite>MySQL 5.7 Reference Manual <a href="http://dev.mysql.com/doc/refman/5.7/en/option-file-options.html#option_general_defaults-extra-file">5.2.7 Command-Line Options that Affect Option-File Handling</a></cite></footer>
{: class="blockquote" cite="http://dev.mysql.com/doc/refman/5.7/en/option-file-options.html#option_general_defaults-extra-file"}

## Usage examples

Having the credentials in a configuration file makes it possible to
create scripts and automate tasks easily.

### MySQL Backup script

Having this configuration we can easily make a backup script to build
a [cronjob](https://en.wikipedia.org/wiki/Cron) and automatically
backup the database regularly using <kbd>mysqldump</kbd>. Edit the
file `backup.sh` with the following content.

~~~ bash
#!/bin/bash
# Backup database from console
DATABASE=
DEFAULTS_FILE=$DATABASE.cnf
BACKUP_DIR=
LOGS_DIR=

DB_OUT_FILENAME=$DEFAULTS_FILE-`date +\%Y\%m\%d`.sql.gz
mysqldump --defaults-extra-file=$DEFAULTS_FILE $DATABASE 2>> $LOGS_DIR/$DATABASE.log | gzip - > $BACKUP_DIR/$DB_OUT_FILENAME
~~~

Then make it executable <kbd>chmod +x backup.sh</kbd>

### Truncate MySQL tables from console

>  TRUNCATE TABLE empties a table completely. It requires the DROP privilege. 
> <footer class="blockquote-footer"> <cite>MySQL 5.7 Reference Manual in <a href="http://dev.mysql.com/doc/refman/5.7/en/truncate-table.html">14.1.34 TRUNCATE TABLE Syntax</a></cite></footer>
{: class="blockquote" cite="http://dev.mysql.com/doc/refman/5.7/en/truncate-table.html"}

We can remove all the content from all the tables of a database
automatically with the following script `truncate_db.sh`:

~~~
#!/bin/bash
# Truncate database tables from console
DATABASE=
DEFAULTS_FILE=$DATABASE.cnf

mysql --defaults-extra-file="$DEFAULTS_FILE" -Nse 'show tables' $DATABASE | while read table; do mysql --defaults-extra-file="$DEFAULTS_FILE" -e "truncate table $table" $DATABASE; done
~~~

Then make it executable <kbd>chmod +x truncate_db.sh</kbd>.

## Summary

Using MySQL options file, it is very easy to setup a safer environment
than executing commands with the user or password shown in console.

Backing up the database or perform any other task from console with
the `mysql` or `mysqldump` command becomes trivial.

## References

- <https://gist.github.com/marcanuy/5977648>
- <http://dev.mysql.com/doc/refman/5.7/en/option-files.html>

*[MySQL]: My Structured Query Language
*[VPS]: Virtual Private Server
