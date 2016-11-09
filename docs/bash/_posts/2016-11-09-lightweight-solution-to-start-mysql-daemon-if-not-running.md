---
title: Bash Script to Find Out If MySQL Is Running Or Not 
description: A simple shell script to check if mysql server is running and start it if it's not.
layout: post
---

## Overview 

This is a simple solution to monitor the MySQL daemon, if it detects
that the daemon is not running, it starts it and send a notification
email.

It is a simpler solution than using other more complete software like
*supervisord* or *MonIT*.

## Creating the script

Create the script `/root/scripts/monitor_mysql.sh` with the following
content:

~~~ bash
#!/bin/bash

##########
# Config #
##########
mysql_daemon='mysqld'
pgrep='/usr/bin/pgrep'
mysql_start='sudo service mysql start'
fail_msg="MySQL is down in $(hostname)."

##########
# Script #
##########

#look up process
$pgrep $mysql_daemon > /dev/null
if [ $? -ne 0 ]; then
    echo $fail_msg
    $mysql_start
fi
~~~

And make it executable:

<pre class="shell">
<samp>
<span class="shell-prompt">#</span> <kbd>chmod +x /root/scripts/monitor_mysql.sh</kbd>
</samp>
</pre>


## Cronjob

Specify through `crontab` to run it every 10 minutes. Running

<pre class="shell">
<samp>
<span class="shell-prompt">#</span> <kbd>crontab -e</kbd>
</samp>
</pre>

Add the following lines:

~~~
MAILTO=mail@example.com
*/10 * * * * /root/scripts/monitor_mysql.sh
~~~

Every time the script starts the daemon, an email will be sent with
its output.

> cron(8) looks at the MAILTO variable if a mail needs to be send as a
> result of running any commands in that particular crontab.  If
> MAILTO is defined (and non-empty), mail is sent to the specified
> address.  If MAILTO is defined but empty (MAILTO=""), no mail is
> sent.  Otherwise, mail is sent to the owner of the crontab.
> <footer class="blockquote-footer"> <cite>Crontab <a href="http://man7.org/linux/man-pages/man5/crontab.5.html">man description</a></cite></footer>
{: class="blockquote" cite="http://man7.org/linux/man-pages/man5/crontab.5.html"}

## Reference

- Crontab <http://man7.org/linux/man-pages/man5/crontab.5.html>
- [Simple bash script to check whether MySQL is running](https://gist.github.com/mheadd/5571023)
