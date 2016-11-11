---
description: A detailed guide to contribute to a project in Github
layout: post
---

## Overview

Simply guide to contribute to any project in Github. The basic
workflow consist of

- Fork the repository
- Make a fix or contribution
- Submit a pull request to the original project

## Forking 

> A fork is a copy of a repository. Forking a repository allows you to
> freely experiment with changes without affecting the original
> project. 
> <footer class="blockquote-footer"> <cite>Fork A Repo in <a href="https://help.github.com/articles/fork-a-repo/">Github help</a></cite></footer>
{: class="blockquote" cite="https://help.github.com/articles/fork-a-repo/"}

Go to the project you want to contribute and press the **Fork**
button.

![fork](https://github-images.s3.amazonaws.com/help/bootcamp/Bootcamp-Fork.png) 

That will generate a copy of the repository in your Github profile
where you can work with the code.

In this example I will fork the following
repo: <https://github.com/housed/feedr>

## Clone the forked repo

Make a local copy of the forked repo with `git clone`.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>git clone https://github.com/marcanuy/feedr.git</kbd>
Cloning into 'feedr'...
remote: Counting objects: 65, done.
remote: Total 65 (delta 0), reused 0 (delta 0), pack-reused 65
Ricezione degli oggetti: 100% (65/65), 178.73 KiB | 282.00 KiB/s, done.
Risoluzione dei delta: 100% (22/22), done.
Checking connectivity... fatto.
<span class="shell-prompt">$</span> <kbd>cd feedr</kbd>
<span class="shell-prompt">feedr$</span>
</samp>
</pre>

## Configure the original repo as a remote

Having the original repo as a remote makes it possible to keep your
code up to date with all the contributions made to the original repo
and contribute your own code.

The convention is to name this remote repo `upstream`.

<pre class="shell">
<samp>
<span class="shell-prompt">feedr$</span> <kbd>git remote add upstream https://github.com/housed/feedr.git</kbd>
<span class="shell-prompt">feedr$</span> <kbd>git remote -v</kbd>
origin  git@github.com:marcanuy/feedr.git (fetch)
origin  git@github.com:marcanuy/feedr.git (push)
upstream        https://github.com/housed/feedr.git (fetch)
upstream        https://github.com/housed/feedr.git (push)
</samp>
</pre>

## Create a branch

Create a topic branch where you fix or improve the code and move to
that branch.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>git checkout -b fix-indentation</kbd>
Switched to a new branch 'fix-indentation'
</samp>
</pre>

## Create a branch with new changes

After working in the new branch, making some changes and _commits_,
push the new branch,`fix-indentation` in this case, to your Github
repo.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>git push origin fix-indentation</kbd>
Counting objects: 4, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 367 bytes | 0 bytes/s, done.
Total 4 (delta 2), reused 0 (delta 0)
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To github.com:marcanuy/feedr.git
 * [new branch]      fix-indentation -> fix-indentation
</samp>
</pre>

## Create a pull request

Now your changes are in a new branch in your Github repo, it is time
to make a _pull request_ to merge your changes in the original repo.

The Github repo webpage shows:

> Your recently pushed branches:
>     fix-indentation (less than a minute ago) 

and makes it available a button to send the __Pull Request__.

After pressing the __Pull request__ button, the webpage redirects to
__Open a pull request__ page, after selecting the base fork and the
head fork, you can make the __pull request__.

Now just wait to the repo owner to merge your fixes.

> marcanuy wants to merge 1 commit into housed:master from  marcanuy:fix-indentation
 
[Github]: http://github.com/
