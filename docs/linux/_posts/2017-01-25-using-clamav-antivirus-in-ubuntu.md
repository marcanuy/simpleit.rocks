---
description: How to scan for viruses with ClamAV in Ubuntu.
tags: antivirus, security
---

## Overview

There are viruses for all platforms, they are just more common on
Windows. 

Having an antivirus in Linux is just another tool to help you protect
the system, you won't be entirely safe just using it, you also need
safe practices.

We will install *ClamAV*, one of the most popular antivirus software
for Linux.

> ClamAV® is an open source antivirus engine for detecting trojans,
> viruses, malware & other malicious threats.
> 
> <footer class="blockquote-footer"> <cite><a href="https://www.clamav.net/"></a></cite></footer>
{: class="blockquote" cite="https://www.clamav.net/"}

## Why do we need antivirus in Linux

My choice is to have an antivirus to run from time to time or at
suspicious files and folders, but **not having it running as
daemon** to avoid a performance decrease in the system.

## Install

To install we use the *clamav* package:

<pre class="shell">
<samp>
<span class="shell-prompt">#</span> <kbd>apt-get install clamav</kbd>
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Suggested packages:
  clamav-docs
The following NEW packages will be installed:
  clamav
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 0 B/90.5 kB of archives.
After this operation, 695 kB of additional disk space will be used.
Selecting previously unselected package clamav.
(Reading database ... 34590 files and directories currently installed.)
Preparing to unpack .../clamav_0.99.2+addedllvm-0ubuntu0.14.04.1_amd64.deb ...
Unpacking clamav (0.99.2+addedllvm-0ubuntu0.14.04.1) ...
Processing triggers for man-db (2.6.7.1-1ubuntu1) ...
Setting up clamav (0.99.2+addedllvm-0ubuntu0.14.04.1) ...
</samp>
</pre>

### Update db

Now we need to update the signatures so we have our virus database
updated with `freshclam`.

<pre class="shell">
<samp>
<span class="shell-prompt">#</span> <kbd>freshclam</kbd>
ClamAV update process started at Wed Jan 25 15:05:36 2017
Downloading main.cvd [100%]
main.cvd updated (version: 57, sigs: 4218790, f-level: 60, builder: amishhammer)
Downloading daily.cvd [100%]
daily.cvd updated (version: 22948, sigs: 1449757, f-level: 63, builder: neo)
Downloading bytecode.cvd [100%]
bytecode.cvd updated (version: 289, sigs: 57, f-level: 63, builder: neo)
Database updated (5668604 signatures) from db.local.clamav.net (IP: 155.98.64.87)
</samp>
</pre>

## Scan commands

To scan a directory recursively we use `-r` and `-i` to just display
the infected files.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>clamscan -r --bell -i ~/Downloads/</kbd>

----------- SCAN SUMMARY -----------
Known viruses: 5663100
Engine version: 0.99.2
Scanned directories: 61
Scanned files: 380
Infected files: 0
Data scanned: 1077.08 MB
Data read: 551.12 MB (ratio 1.95:1)
Time: 298.129 sec (4 m 58 s)
</samp>
</pre>

## Other notes

Some other good security recommendations: 

- keep software updated
- beware phishing sites (browsing through web pages that looks like
  another popular ones)
- analyze command before running them or use trusted sources.

## References

- <https://help.ubuntu.com/community/ClamAV>
- [How do I scan for viruses with ClamAV?](http://askubuntu.com/q/250290/43253)

*Tested in Ubuntu 16.10*
  
*[OSs]: Operating Systems
