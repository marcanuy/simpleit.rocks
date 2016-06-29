---
title: Remotes
layout: post
---

<https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes>

Remote repositories are versions of your project that are hosted on the Internet or network somewhere. The clone command implicitly adds the origin remote for you.

+ Show remotes `$ git remote -v`
+ Add a remote `$ git remote add pb https://github.com/paulboone/ticgit`
+ To get data from a remote project `$ git fetch [remote-name]`
+ If your current branch is set up to track a remote branch, you can use the _git pull_ command to automatically fetch and then merge that remote branch into your current branch `$ git pull `
