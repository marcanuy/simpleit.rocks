---
title: Creating a git server from a git repo
layout: tutorial
tags:
- git
- server
- bare-repository
description: >
  Having a git server and a repo in another computer not present in the <br>
  server, create a centralized version of the repo in the server.
current: >
  graph TB
    subgraph Server
        srv["git server"]
    end
    subgraph New Client
        repo2[" "]
    end
    subgraph Client
        repo["git repo <br /> 'myproject'"]
    end
goal: >
  graph TB
    subgraph Server
        srv["'myproject' bare repo"]
    end
    subgraph New Client
        repo["cloned 'myproject' repo"]==>srv
    end
    subgraph Client
        client["'myproject' repo"]==>srv
    end
flow: >
  sequenceDiagram
    participant Alice
    participant Server
    participant Bob
    Alice->>Alice: Create bare repository
    Alice->>Server: Copy repo to remote server
    Alice->>Alice: Add remote
    Bob-->>Server: Clone repo from remote server
---

## Overview

A Git project commonly consists of three main sections in a Developer environment and 
a single section in a Git Server:

<div class="mermaid">
graph TB
    subgraph GitServer
      server["Git"]==>bare["the Git directory"]
    end
    subgraph DeveloperRepo
      git["Git"]
      git==>dir["the Git directory <br /> .git"]
      git==>stage["Staging Area"]
      git==>work["Working Directory"]
    end
</div>

In order to "move" a git repo to a git server, a special directory 
has to be generated first. This is called a _bare repository_, a directory
that only contains the git data but not the project source code files,
just like the __.git__ directory.

Then this _bare repo_ should be moved to the server, so the server acts as
 a common _git server_.

The repo from which the server was generated needs to add the _git server_ as a 
_remote_ and every other developer that wants to work in that project can
_clone_ it from the server directly.

## Create bare repository 

In order to set up a Git server, you have to export an existing repository
into a new _bare repository_ (a repository that doesn’t contain 
a _working directory_). This can be done with
[git clone](https://git-scm.com/docs/git-clone) `--bare` parameter.

> `--bare` Make a bare Git repository. That is, instead of creating
> _directory_ and placing the administrative files in _directory_/.git
> make the _directory_ itself the `$GIT_DIR`.
{: cite="https://git-scm.com/docs/git-clone" class="alert alert-info"}

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>git clone --bare my_project my_project.git</kbd>
Cloning into bare repository my_project.git...
done.
</samp>
</pre>

## Copy repo to remote server 

Put the bare repository in the server.


<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>scp -r my_project.git user@gitserver.com:/srv/git</kbd>
<span class="shell-prompt">$</span> <kbd>rm -r my_project.git</kbd>
</samp>
</pre>

## Add server repo as a remote in local repo 

After having the repo in the remote server, the git server remote should be
added to the local repo so it is possible to pull and push changes to it.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>cd my_project</kbd>
<span class="shell-comment"># Set a new remote</span>
<span class="shell-prompt">(my_project)$</span> <kbd>git remote add origin user@gitserver.com:/srv/git/my_project.git</kbd>
</samp>
</pre>

> To also specify a different port from ssh default (22): `git remote add origin ssh://user@gitserver.com:2222/srv/git/my_project.git`
{: class="alert alert-info" role="alert"}

### Verify new remote

<pre class="shell">
<samp>
<span class="shell-prompt">(my_project)$</span> <kbd>git remote -v</kbd>
origin  user@gitserver.com:/srv/git/my_project.git (fetch)
origin  user@gitserver.com:/srv/git/my_project.git (push)
</samp>
</pre>

## Summary

This is a simple way of enabling other users to contribute to your
projects and having a centralized repository where your main stuff
goes. 

Now every other user that wants to contribute should `clone` the
server repo and keep that up to date.

## References 

- <https://git-scm.com/docs/git-clone>
- <https://git-scm.com/book/en/v2/Git-on-the-Server-Getting-Git-on-a-Server>
- <https://git-scm.com/book/ch4-1.html>
