---
title: Git Basic Concepts
layout: post
description: Fundamental concepts to understand how Git works.
---

## Stream of snapshots ##

Git saves data like a __stream of snapshots__. Every time you commit, or save the state of your project in Git, it basically takes a picture of what all your files look like at that moment and stores a reference to that snapshot. if files have not changed, Git doesn’t store the file again, just a link to the previous identical file it has already stored.

## Integrity ##

Git has __integrity__. Everything in Git is check-summed before it is stored and is then referred to by that checksum. It uses [SHA-1](https://en.wikipedia.org/wiki/SHA-1).

## File states ##

There are three _file states_:

+ __Committed__ means that the data is stored in your local database.
+ __Modified__ means that you have changed the file but have not committed it to your database yet.
+ __Staged__ means that you have marked a modified fi\e in its current version to go into your next commit snapshot.

### Lifecycle of the status of files ###

<div class="mermaid">
sequenceDiagram
    Untracked ->> Staged: Add the file
    Unmodified ->> Modified: Edit the file
   	Modified ->> Staged: Stage the file
    Unmodified ->> Untracked: Remove the file
    Staged ->> Unmodified: Commit
</div>

### Main Sections ###
Sections of a Git project:     

+ the _Git directory_ is where Git stores the metadata and object database
  for your project. It is copied when cloning a repo.
+ the _working directory_ is a single checkout of one version of the 
  project. These files are pulled out of the compressed database in the Git
  directory and placed on disk for you to use or modify.
+ the _staging area_ is a file, generally contained in your Git directory,
  that stores information about what will go into your next commit. 
  It’s sometimes referred to as the __index__.

<div class="mermaid text-sm-center">
graph TB
      git["Git Project Sections"]
      git==>dir["the Git directory <br /> .git"]
      git==>stage["Staging Area"]
      git==>work["Working Directory"]
</div>
