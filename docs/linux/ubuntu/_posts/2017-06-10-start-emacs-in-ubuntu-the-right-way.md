---
title: Start Emacs in Ubuntu The Right Way
description: We explore how to have Emacs in Ubuntu running as a serviced unit and define some useful aliases and environment variables.
---

## Overview

Emacs can
be
[slow to start up](http://www.geekherocomic.com/2009/02/02/emacs-vs-vim/),
if you use it constantly this can be a problem.

Fortunately, there is a `daemon` version of Emacs that you can start
once per session, loading the initialization file, and then connect to
the running process with <kbd>emacsclient</kbd> fast.

>--daemon
>	 Start  Emacs  as  a daemon, enabling the Emacs server and disconnecting from the terminal.  You can then use
>	 the emacsclient command to connect to the server (see emacsclient(1)).
> 
> <footer class="blockquote-footer"> <cite>Emacs man page</cite></footer>
{: class="blockquote"}

From Ubuntu 15.04, [systemd] has become the default init system.

> systemd is a suite of basic building blocks for a Linux system. It
> provides a system and service manager that runs as PID 1 and starts
> the rest of the system.
> 
> <footer class="blockquote-footer"> <cite><a href="https://www.freedesktop.org/wiki/Software/systemd/">systemd System and Service Manager</a></cite></footer>
{: class="blockquote" cite="https://www.freedesktop.org/wiki/Software/systemd/"}

In this tutorial we will create a new *systemd* service to handle the
Emacs server so we will be able to `start`, `stop`, `restart`,
`enable` and `disable` the service as any other Linux service.

[Systemd]: https://www.freedesktop.org/wiki/Software/systemd

## systemd Unit

To turn Emacs into a *systemd* service that can be started automatically
during system startup we will create a service to start the daemon.

*systemd* can manage services under the user's control with a
per-user *systemd* instance, enabling users to handle their own units.

User services like this one, should be placed in
`~/.config/systemd/user/` so then we will be able to run them with
<kbd>systemctl --user enable *service*</kbd>.

> --user
>    Talk to the service manager of the calling user, rather than the service manager of the system.
> 
> <footer class="blockquote-footer"> <cite><a href="https://wiki.archlinux.org/index.php/Systemd/User#Basic_setup">systemctl --help</a></cite></footer>
{: class="blockquote" cite="https://wiki.archlinux.org/index.php/Systemd/User#Basic_setup"}

The resources that *systemd* knows how to manage are called *units*.

> A unit configuration file whose name ends in `.service` encodes
> information about a process controlled and supervised by systemd.
> 
> <footer class="blockquote-footer"> <cite><a href="https://www.freedesktop.org/software/systemd/man/systemd.service.html">systemd.service — Service unit configuration</a></cite></footer>
{: class="blockquote" cite="https://www.freedesktop.org/software/systemd/man/systemd.service.html"}

*systemd* --user instance is a per-user process, and not per-session. 
{: .alert .alert-danger}

In `~/.config/systemd/user/emacs.service`:

~~~
[Unit]
Description=Emacs Daemon

[Service]
Type=forking
ExecStart=/usr/bin/emacs --daemon
ExecStop=/usr/bin/emacsclient --eval "(progn (setq kill-emacs-hook 'nil) (kill-emacs))"
Restart=always

[Install]
WantedBy=default.target
~~~

## Start server

Now we enable the *unit* to be started at login with <kbd>systemctl
--user enable emacs.service</kbd> and start the service for the
current session <kbd>systemctl --user start emacs.service</kbd>:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>systemctl --user enable emacs.service</kbd>
Created symlink ~/.config/systemd/user/default.target.wants/emacs.service → ~/.config/systemd/user/emacs.service.
<span class="shell-prompt">$</span> <kbd>tree .config/systemd/user/</kbd>
.config/systemd/user/
├── default.target.wants
│   └── emacs.service -> ~/.config/systemd/user/emacs.service
└── emacs.service

1 directory, 2 files
<span class="shell-prompt">$</span> <kbd>systemctl --user list-unit-files|grep emacs</kbd>
emacs.service                           enabled
<span class="shell-prompt">$</span> <kbd>systemctl --user status emacs.service</kbd>
● emacs.service - Emacs Daemon
   Loaded: loaded (~/.config/systemd/user/emacs.service; enabled; vendor preset: enabled)
   Active: inactive (dead)
<span class="shell-prompt">$</span> <kbd>systemctl --user start emacs.service</kbd>
<span class="shell-prompt">$</span> <kbd>systemctl --user status emacs.service</kbd>
   Loaded: loaded (~/.config/systemd/user/emacs.service; enabled; vendor preset: enabled)
   Active: active (running) since Sat 2017-06-10 15:13:33 -03; 1min 23s ago
  Process: 22639 ExecStop=/usr/bin/emacsclient --eval (progn (setq kill-emacs-hook 'nil) (kill-emacs)) (code=exited, status=0/SUCCESS)
  Process: 22782 ExecStart=/usr/bin/emacs --daemon (code=exited, status=0/SUCCESS)
 Main PID: 22783 (emacs)
   CGroup: /user.slice/user-1000.slice/user@1000.service/emacs.service
           └─22783 /usr/bin/emacs --daemon

jun 10 15:13:30 scarone emacs[22782]: ad-handle-definition: ‘moccur-mode’ got redefined
jun 10 15:13:30 scarone emacs[22782]: ad-handle-definition: ‘moccur-grep-mode’ got redefined
jun 10 15:13:30 scarone emacs[22782]: Loading ~/.emacs.d/.mc-lists.el (source)...
jun 10 15:13:30 scarone emacs[22782]: Loading ~/.emacs.d/.mc-lists.el (source)...done
jun 10 15:13:31 scarone emacs[22782]: [yas] Prepared just-in-time loading of snippets successfully.
jun 10 15:13:32 scarone emacs[22782]: [yas] Prepared just-in-time loading of snippets successfully.
jun 10 15:13:32 scarone emacs[22782]: Turning on magit-auto-revert-mode...
jun 10 15:13:32 scarone emacs[22782]: Turning on magit-auto-revert-mode...done
jun 10 15:13:33 scarone emacs[22782]: Starting Emacs daemon.
jun 10 15:13:33 scarone systemd[1858]: Started Emacs Daemon.

</samp>
</pre>

## Final tweaks

### Command aliases

I've [found](https://www.emacswiki.org/emacs/EmacsAsDaemon) these
aliases helpful to have at hand:

emacsclient -t
: open a new Emacs frame on the current terminal (similar to `emacs -nw`)

emacsclient -c -a emacs
: **-c** create a new frame instead of trying to use the current Emacs frame
: **-a** --alternate-editor=EDITOR, if  the  Emacs  server  is not running, run the specified editor instead.

~~~ bash
alias emax="emacsclient -t"
alias semac="sudo emacsclient -t"
alias emacsc="emacsclient -c -a emacs"           # new - opens the GUI with alternate non-daemon
~~~

### Default editor

Finally, set the `EDITOR` and `VISUAL` environment variables so
`emacs` is your default editor:

EDITOR
: The name of the lightweight text editor

VISUAL
: command to run the full-fledged editor

In `.bashrc`:

~~~ bash
export ALTERNATE_EDITOR=""
# $EDITOR should open in terminal
export EDITOR="emacsclient -t"
# $VISUAL opens in GUI with non-daemon as alternate
export VISUAL="emacsclient -c -a emacs"
~~~

## Conclusion

We created a script to run like a native Ubuntu service, then added
some aliases and defined environment variables. Now we have a better
experience in Ubuntu using Emacs with faster loading times and more
integrated to the OS.

## Reference

- systemd/User <https://wiki.archlinux.org/index.php/Systemd/User#Basic_setup>
- EmacsAsDaemon <https://www.emacswiki.org/emacs/EmacsAsDaemon>
- <https://www.freedesktop.org/software/systemd/man/systemd.service.html>
- [Using emacsclient to Speed up Editing](https://taingram.org/2017/05/09/using-emacsclient-to-speed-up-editing/)
