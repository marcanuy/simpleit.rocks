---
description: How to get a list of all installed packages on an Ubuntu server and install them in another machine.
---

## Overview

This guide shows how to restore all packages used in an Ubuntu
instance into another one, to have the same programs available.

Having a backup of the software used is a good practice to easily
replicate your environments accross multiple machines.

We explore some methods to achieve this with their pros and cons.

## Using dpkg

> dpkg is a package manager for Debian-based systems. It can install,
> remove, and build packages, but unlike other package management
> systems, it cannot automatically download and install packages or
> their dependencies.
> 
> <footer class="blockquote-footer"> <cite>Official docs <a href="https://help.ubuntu.com/lts/serverguide/dpkg.html">dpkg</a></cite></footer>
{: class="blockquote" cite="https://help.ubuntu.com/lts/serverguide/dpkg.html"}

In one machine, we make a local copy of the package selection states running:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>dpkg --get-selections > packages.txt</kbd>
</samp>
</pre>

<dl class="row"> 
<dt class="col-sm-3">dpkg --get-selections</dt> 
<dd class="col-sm-9">
	Get list of package selections, and write it to
	stdout. Without a pattern, non-installed packages (i.e. those
	which have been previously purged) will not be shown.
</dd> 
</dl>

The `packages.txt` file will look like:

~~~
...
xterm                                           install
xtrans-dev                                      install
xubuntu-artwork                                 install
xul-ext-ubufox                                  install
xz-utils                                        install
yarssr                                          install
yelp                                            install
youtube-dl                                      install
zeitgeist-core                                  install
zenity                                          install
zenity-common                                   install
zip                                             install
~~~

Then we can backup this file to restore it later on another machine.

To install these selections we need to do it in three steps:

### Update available file

Update the **available** file with the package manager.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>sudo apt-cache dumpavail | sudo dpkg --merge-avail</kbd>
Updating available packages info, using -.
Information about 85628 packages was updated.
</samp>
</pre>

<dl class="row">
<dt class="col-sm-3">apt-cache dumpavail</dt>
<dd class="col-sm-9"><blockquote>dumpavail prints out an available list to stdout. This is suitable for use with dpkg(1) and is used by the dselect method.</blockquote></dd>
<dt class="col-sm-3">dpkg --merge-avail</dt>
<dd class="col-sm-9"><blockquote>Update dpkg's and dselect's idea of which packages are available. With action --merge-avail, old information is combined with information from Packages-file. dpkg keeps its record of available packages in /var/lib/dpkg/available.</blockquote></dd>
</dl>

### Set selection state

Set the selection state on the requested packages with `dpkg`:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>dpkg --set-selections < packages.txt</kbd>
</samp>
</pre>

<dl class="row">
<dt class="col-sm-3">dpkg --clear-selections</dt>
<dt class="col-sm-3">dpkg --set-selections</dt>
<dd class="col-sm-9">Set package selections using file read from stdin.</dd>
</dl>

### Download and install

Packages are not installed yet, to download and install the requested
packages. Execute `apt-get` to perform the installation of the packages
specified previously in our file.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>sudo apt-get -u dselect-upgrade</kbd>
Reading package lists... Done
Building dependency tree       
Reading state information... Done
...
</samp>
</pre>

<dl class="row">
<dt class="col-sm-3">apt-get -u dselect-upgrade</dt>
<dd class="col-sm-9"><blockquote>dselect-upgrade is used in conjunction with the traditional Debian packaging front-end, dselect.  dselect-upgrade follows the changes made by dselect(1) to the Status field of available packages, and performs the actions necessary to realize that state (for instance, the removal of old and the installation of new packages).</blockquote>
</dd>
</dl>

## Using apt-mark

<kbd>apt-mark</kbd> handles various settings for packages. We can
separate our backup files in two files:

1. One will hold the packages installed automatically
2. Other file will hold the packages we install manually

<dl class="row">
<dt class="col-sm-3">apt-mark showauto</dt>
<dd class="col-sm-9"><blockquote>showauto is used to print a list of automatically installed packages with each package on a new line. All automatically installed packages will be listed if no package is given. If packages are given only those which are automatically installed will be shown.</blockquote>
</dd>
<dt class="col-sm-3">apt-mark showmanual</dt>
<dd class="col-sm-9"><blockquote>showmanual can be used in the same way as showauto except that it will print a list of manually installed packages instead.</blockquote>
</dd>
</dl>

So we create these two files:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>apt-mark showauto > pkgs_auto.lst</kbd>
<span class="shell-prompt">$</span> <kbd>apt-mark showmanual > pkgs_manual.lst</kbd>
</samp>
</pre>

Then we restore the files in the target machine:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>sudo apt-mark auto $(cat pkgs_auto.lst)</kbd>
<span class="shell-prompt">$</span> <kbd>sudo apt-mark manual $(cat pkgs_manual.lst)</kbd>
</samp>
</pre>

<dl class="row">
<dt class="col-sm-3">apt-mark auto</dt>
<dd class="col-sm-9"><blockquote>auto is used to mark a package as
being automatically installed, which will cause the package to be removed when no more manually installed packages depend on this package.</blockquote>
</dd>
<dt class="col-sm-3">apt-mark manual</dt>
<dd class="col-sm-9"><blockquote>manual is used to mark a package as being manually installed, which will prevent the package from being automatically removed if no other packages depend on it.</blockquote>
</dd>
</dl>

## Conclusions

The problem with the first method is that package dependencies get
lost, so each package don't know what other packages are related to
them, which makes something like <kbd>apt-get --purge remove ...</kbd>
problematic. 

On the other side, the second method is safer and keeps all the
dependencies, and even know if they were installed automatically or
manually which makes it more suitable for this task.

## References

- dpkg Ubuntu docs <https://help.ubuntu.com/lts/serverguide/dpkg.html>
- Advanced Packaging
  Tool <https://en.wikipedia.org/wiki/Advanced_Packaging_Tool>
- [htorque](https://askubuntu.com/users/3037/htorque) answer in [Restoring all data and dependencies from dpkg --set-selections '*'](https://askubuntu.com/a/108760/43253)
