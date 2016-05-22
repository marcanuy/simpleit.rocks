GIT
===

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-generate-toc again -->
**Table of Contents**

- [GIT](#git)
    - [Basic Concepts](#basic-concepts)
    - [Commands](#commands)
    - [Set up a Git server](#set-up-a-git-server)
- [References](#references)

<!-- markdown-toc end -->

## Basic Concepts ##

+ Git saves data like a __stream of snapshots__. Every time you commit, or save the state of your project in Git, it basically takes a picture of what all your files look like at that moment and stores a reference to that snapshot. if files have not changed, Git doesn’t store the file again, just a link to the previous identical file it has already stored.

+ Git has __integrity__. Everything in Git is check-summed before it is stored and is then referred to by that checksum. It uses SHA-1.

+ There are three _file states_:
  + __Committed__ means that the data is stored in your local database. 
  + __Modified__ means that you have changed the file but have not committed it to your database yet. 
  + __Staged__ means that you have marked a modified file in its current version to go into your next commit snapshot.

+ Sections of a Git project:
  + the _Git directory_ is where Git stores the metadata and object database for your project. It is copied when cloning a repo.
  + the _working directory_ is a single checkout of one version of the project. These files are pulled out of the compressed database in the Git directory and placed on disk for you to use or modify.
  + the _staging area_ is a file, generally contained in your Git directory, that stores information about what will go into your next commit. It’s sometimes referred to as the “index”.

## Commands ##

    $ git config --list
	
## Set up a Git server ##

( https://git-scm.com/book/en/v2/Git-on-the-Server-Getting-Git-on-a-Server )

In order to set up a Git server, you have to export an existing repository into a new _bare repository_ (a repository that doesn’t contain a _working directory_).

`$ git clone --bare my_project my_project.git` 

Put the bare repository in the server.

`$ scp -r my_project.git user@git.example.com:/srv/git` 
`$ rm -r my_project.git`

References
==========

+ [Git book](https://git-scm.com/book/en/v2) 
+ -







