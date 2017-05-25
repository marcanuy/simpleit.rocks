---
description: How to run no more than one unique instance of a script or command. Prevent duplicate cron jobs running.
layout: post
---

## Overview 

When you set up a cron job, sometimes you need to make sure that you
will always have just **one running instance at a time**. This is
useful also when you want to be sure that a script that can take
longer than expected does not get executed again if the previous call
hasn't finished.

This can be done with another *caller* shell script that detects a
running instance before executing it again (e.g.: using `pidof`), or
you can use programs written specifically to handle this situation
(e.g.: `flock` or `run-once`).

In this tutorial we will be using different approaches to have just
one instance of an example script called `main.sh` that simply prints
"Hello" in an infinite while loop.

~~~ bash
#!/bin/sh
while true
 do
    echo "Hello"
    sleep 2
 done
~~~

And make it executable.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>chmod +x main.sh</kbd>
<span class="shell-prompt">$</span> <kbd>./main.sh</kbd>
Hello
Hello
...
</samp>
</pre>

## Script approach

We make a script `caller.sh` that launches the program we want to run
only if the process' *id* of the script isn't already running.

<div class="mermaid">
graph TD
    shell["$ caller.sh"]
    if{"Is main.sh running?"}
	shell-->if
	if-->|yes|exit1
	if-->|not|main.sh
	main.sh-->exit0["Exit Status 0"]
</div>

To find the process ID of our running script (omitting the calling
script) we use <kbd>pidof</kbd>.

In `caller.sh`:

~~~ bash
if pidof -o %PPID -x "main.sh">/dev/null; then
    echo "Process already running"
	exit 1
fi
~~~

~~~
-x     Scripts too - this causes the program to also return process id's of shells running the named scripts.
-o omitpid
             Tells pidof to omit processes with that process id. The special pid %PPID can be used to name the parent process  of
             the pidof program, in other words the calling shell or shell script.
EXIT STATUS
	0      At least one program was found with the requested name.
	1      No program was found with the requested name.
~~~

Then the first time we run <kbd>caller.sh</kbd> it will launch
<kbd>main.sh</kbd>, successive calls would exit the script.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>./caller.sh</kbd>
Hello
Hello
...
</samp>
</pre>

If we try to launch it again from another shell:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>./caller.sh</kbd>
./main.sh already running
</samp>
</pre>

## Lock file approach

A **lock file** is an ordinary file that it is created before executing the
script, and removed after the script finishes.

This way if any other command tries to execute the same script **using
the same lock file** it will exit or wait until it can run it.

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

It is a good practice to avoid duplicate running instances of
cron jobs as they may lead to several problems that should not be
overlooked and handled accordingly when defining them.

## Reference

- Crontab <http://man7.org/linux/man-pages/man5/crontab.5.html>
- [Prevent duplicate cron jobs running](http://serverfault.com/q/82857/135885)
- [File locking](https://en.wikipedia.org/wiki/File_locking)
- [shell script execution check if it is already running or not](http://stackoverflow.com/a/28563464/1165509)
- [pidof(8) - Linux man page](https://linux.die.net/man/8/pidof)
- [flock(1) - Linux man page](https://linux.die.net/man/1/flock)
- [run-one Ubuntu manual](http://manpages.ubuntu.com/manpages/precise/man1/run-one.1.html)
