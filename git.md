GIT
===

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-generate-toc again -->
**Table of Contents**

- [GIT](#git)
    - [Basic Concepts](#basic-concepts)
        - [Remotes](#remotes)
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

### Commands ###

  + Git Config `$ git config --list`
	
  + Git config username and email for all repos
	  
	  `$ git config --global user.name "John Doe"`
	  
	  `$ git config --global user.email "your_email@example.com"`
	
  + Initialize a repository. Creates a new subdirectory named .git that contains all of your necessary repository files. `$ git init .`
	
  + Get a copy of an existing Git repo. `$ git clone [url]`

## Remotes ##

<https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes>

Remote repositories are versions of your project that are hosted on the Internet or network somewhere. The clone command implicitly adds the origin remote for you.

+ Show remotes `$ git remote -v`
+ Add a remote `$ git remote add pb https://github.com/paulboone/ticgit`
+ To get data from a remote project `$ git fetch [remote-name]`
+ If your current branch is set up to track a remote branch, you can use the _git pull_ command to automatically fetch and then merge that remote branch into your current branch `$ git pull `

## Set up a Git server ##

<https://git-scm.com/book/en/v2/Git-on-the-Server-Getting-Git-on-a-Server>

In order to set up a Git server, you have to export an existing repository into a new _bare repository_ (a repository that doesn’t contain a _working directory_).

    $ git clone --bare my_project my_project.git

Put the bare repository in the server.

    $ scp -r my_project.git user@git.example.com:/srv/git
	$ rm -r my_project.git


References
==========

+ [Git book](https://git-scm.com/book/en/v2) 
+ -






