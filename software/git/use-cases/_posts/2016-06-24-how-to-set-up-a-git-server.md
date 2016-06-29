---
title: Set up a Git server
layout: post
---

<https://git-scm.com/book/en/v2/Git-on-the-Server-Getting-Git-on-a-Server>

In order to set up a Git server, you have to export an existing repository into a new _bare repository_ (a repository that doesn’t contain a _working directory_).

~~~ bash
 $ git clone --bare my_project my_project.git
~~~

Put the bare repository in the server.

~~~ bash
 $ scp -r my_project.git user@git.example.com:/srv/git
 $ rm -r my_project.git
~~~
