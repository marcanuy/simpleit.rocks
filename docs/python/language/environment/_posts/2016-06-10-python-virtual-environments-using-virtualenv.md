---
title: Python Virtual Environments
subtitle: Project isolation
description: Handle dependencies and app versions for each project with python virtual environments.
layout: post
tags:
  - virtual-environments
  - virtualenv
  - python
  - packages
  - versioning
---

## Overview

The tipical workflow to isolate a python project consist of the following steps:

1. Create a project dir
2. Create a virtual environment for the project outside its directory 
structure
  - _virtualenvwrapper_ uses the variable WORKON_HOME to specify the 
	location of new virtual environments. The default value is
    __$HOME/.virtualenvs__

Then each time you work on the project you have two alternatives:

+ __Manually activate the virtual environment__ for the project, so it
handles all the commands instead of executing the current Operating 
System ones. `source ~/.virtualenvs/my_project/bin/activate`
+ __Configure a virtualenvwrapper__ and then just select your environment
with a command like: `workon my_project`

## Create a virtual environment

Create the virtual environment (preferable in a directory outside 
the project)

The preferred python version to use in the new environment can also 
be specified.

<pre class="shell">
<samp>
<span class="shell-comment">#Create the project</span>
<span class="shell-prompt">$</span> <kbd>mkdir my_project;</kbd>
<span class="shell-comment">#Create the virtual environment</span>
<span class="shell-prompt">$</span> <kbd>virtualenv -p python3.5 ~/.virtualenvs/my_project</kbd>
</samp>
</pre>

## Use the virtual environment

To use the new environment, it should be _activated_.
Any command executed after activating it, will use the packages
installed in this virtual environment.

Console prompt will change (in most cases) to reflect this situation
prepending the virtual environment name in terminal prompt.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>source ~/.virtualenvs/my_project/bin/activate</kbd>
<span class="shell-prompt">(virtualenv)$</span>
</samp>
</pre>

## Stop using the virtual environment

<pre class="shell">
<samp>
<span class="shell-prompt">(virtualenv)$</span> <kbd>deactivate</kbd>
<span class="shell-prompt">$</span>
</samp>
</pre>

## virtualenvwrapper ##

Virtualenvwrapper makes it easier to perform _virtualenv_ tasks. It is build upon the following concepts:

+  Projects
  + The source code that needs a special virtual environment specified in a _requirements_ file.
  + The base directory for projects is specified in __PROJECT_HOME__.
+ A Virtualenv directory
  + All the _virtualenvs_ for each project will be contained here in subdirectories.
  + Specified in the variable __WORKON_HOME__, by default will be: _$HOME/.virtualenvs_

`mkvirtualenv` provides the same options as `virtualenv` plus a few options. It creates by default the _virtualenv_ environment in `~/.virtualenvs/<env_name>` and then activates it.

<samp>
Usage: mkvirtualenv [-a project_path] [-i package] [-r requirements_file] [virtualenv options] env_name
</samp>

### virtualenvwrapper workflow

Common workflow to work on a new _virtual environment_ using
_virtualenvwrapper_:

- Create the virtual environment (by default in __$WORKON_HOME__)

> The variable WORKON_HOME tells virtualenvwrapper where to place your
> virtual environments. The default is $HOME/.virtualenvs. If the
> directory does not exist when virtualenvwrapper is loaded, it will
> be created automatically.
{: cite="http://virtualenvwrapper.readthedocs.io/en/latest/install.html#variable-workon-home"}
  
- list the available _environments_ and activate the project to work on
with [workon](http://virtualenvwrapper.readthedocs.io/en/latest/command_ref.html#workon)
- Go to the project directory [`cdvirtualenv`](http://virtualenvwrapper.readthedocs.io/en/latest/command_ref.html#cdvirtualenv)
- [deactivate](http://virtualenvwrapper.readthedocs.io/en/latest/command_ref.html#deactivate) the environment when finished working

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>mkvirtualenv myenvname</kbd>
New python executable in /home/marcanuy/.virtualenvs/myenvname/bin/python
Installing setuptools, pip, wheel...done.
<span class="shell-comment text-muted">#the previous created env will appear listed, along the other envs</span>
<span class="shell-prompt">(myenvname)$</span> <kbd>workon</kbd>
myenvname
<span class="shell-comment">#changes to the associated project directory</span>
<span class="shell-prompt">(myenvname)$</span> <kbd>cdvirtualenv myenvname</kbd>
<span class="shell-prompt">(myenvname)/opt/development/myproject$</span> <kbd>cdsitepackages</kbd>
<span class="shell-prompt">(myenvname)~/.virtualenvs/myenvname/lib/python3.5/site-packages$</span> <kbd>cdvirtualenv</kbd>
<span class="shell-comment">#finish work</span>
<span class="shell-prompt">(myenvname)/opt/development/myproject$</span> <kbd>deactivate</kbd>
<span class="shell-prompt">/opt/development/myproject$</span> <span class="cursor">_</span>
</samp>
</pre>

To create a new environment having a requirements file and a specific python version: `mkvirtualenv -r requirements/local.txt -p /usr/bin/python3.5 myprojectname`

## Reference

- virtualenv <https://virtualenv.pypa.io>
- virtualenvwrapper <https://virtualenvwrapper.readthedocs.io>

## Pending

- <https://docs.python.org/3/library/venv.html>
- <https://docs.python.org/3/using/scripts.html#pyvenv-creating-virtual-environments>
- <https://realpython.com/blog/python/python-virtual-environments-a-primer/>
- PEP 405 -- Python Virtual Environments <https://www.python.org/dev/peps/pep-0405>
