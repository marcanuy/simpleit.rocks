---
title: 
description: How to run no more than one unique instance of a script or command.
layout: post
---

## Overview 

When you set up a cronjob you often want no more than one copy running
at a time, so you need to apply a strategy to prevent a cron job from
having multiple running instances when a script takes longer time to
finish. 

This can be done "manually" with a a shell script that detects a
running instance before executing it again, using `pidof`, or you can
take benefit of software that are built to handle this scenario
specifically like `flock` or `run-once`.

## Lock file approach

A lock file is an ordinary file that it is created before executing the
script, and removed after the script finishes. 

This way if any other command tries to execute the same script **using
the same lock file** it will exit or wait until it can execute.

### Using flock

Most Linux distros already comes with
the [flock](http://man7.org/linux/man-pages/man1/flock.1.html)
command. 

> `flock` manages locks from within shell scripts or from the command line.
> <footer class="blockquote-footer"> <cite>Flock in <a href="http://man7.org/linux/man-pages/man1/flock.1.html">User Commands</a></cite></footer>
{: class="blockquote" cite="http://man7.org/linux/man-pages/man1/flock.1.html"}

We use `flock` to execute the script, specifying explicitly the lock
file to use, and to exit if the script is already running with the
`-n` parameter.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>flock -n /tmp/myfind.lock myscript.sh</kbd>
</samp>
</pre>

For example, editing the `crontab` to execute the command every 5 minutes should look like:

~~~ 
*/5 * * * * /usr/bin/flock -n /tmp/ms.lockfile /usr/local/bin/my_script --some-parameter
~~~

Every time the script takes longer than 5 minutes to execute, the
`cronjob` will fail and leave the original script to finish.

### Using run-one

In some *distros* like [Ubuntu](https://apps.ubuntu.com/cat/applications/run-one), there is also
the [run-one](https://launchpad.net/run-one) utility that handles the
lock automatically.

Example crontab with `run-one` for the previous script:

~~~
*/5 * * * *   run-one /usr/local/bin/my_script --some-parameter
~~~

## Summary

These approaches are easier and safer than detecting the running
scripts manually which may lead to other problems. 

Not thinking what could happen if a duplicate running instance of a
cronjob appears can lead to several problems that should not be
overlooked and handled accordingly when defining them.

## Reference

- Crontab <http://man7.org/linux/man-pages/man5/crontab.5.html>
- [Prevent duplicate cron jobs running](http://serverfault.com/q/82857/135885)
- [File locking](https://en.wikipedia.org/wiki/File_locking)
