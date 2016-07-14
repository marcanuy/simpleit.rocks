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

General workflow for python projects isolation:

+ Create a project dir
+ Create a virtual environment for the project outside its directory structure
  + _virtualenvwrapper_ uses the variable WORKON_HOME to specify the location of new virtual environments. The default value is __$HOME/.virtualenvs__
+ Then each time you work on the project you have two alternatives:

+ _Manually activate the virtual environment_ for the project, so it handles all the commands instead of executing the current Operating System ones. `source ~/.virtualenvs/my_project/bin/activate`
  + _Configure a virtualenvwrapper_ and then just select your environment with a command like: `workon my_project`

Common workflow to create a new _virtualenv_:

+ Create the virtual environment (preferable in a directory outside your project)
+ activate the project to work on

```
$ mkdir my_project;
### Create the virtual environment (optionally select python version)
$ virtualenv -p python3.5 ~/.virtualenvs/my_project
### Activate it
$ source ~/.virtualenvs/my_project/bin/activate #the following commands will use the packages installed in this virtual environment
### Your Bash prompt will change to show you are in a virtual environment
(virtualenv)$ ... #work 
(virtualenv)$ deactivate #finish work
$
```

+ virtualenv <https://virtualenv.pypa.io>

## virtualenvwrapper ##

Virtualenvwrapper makes it easier to perform _virtualenv_ tasks. It is build upon the following concepts:

+  Projects
  + The source code that needs a special virtual environment specified in a _requirements_ file.
  + The base directory for projects is specified in __PROJECT_HOME__.
+ A Virtualenv directory
  + All the _virtualenvs_ for each project will be contained here in subdirectories.
  + Specified in the variable __WORKON_HOME__, by default will be: _$HOME/.virtualenvs_

`mkvirtualenv` provides the same options as `virtualenv` plus a few options. It creates by default the _virtualenv_ environment in `~/.virtualenvs/<env_name>` and then activates it.

`Usage: mkvirtualenv [-a project_path] [-i package] [-r requirements_file] [virtualenv options] env_name`

Common workflow to create a new _virtualenv_ with _virtualenvwrapper_:

+ Create the virtual environment (by default in __$WORKON_HOME__)
+ list the available _environments_ and activate the project to work on
+ Go to the project directory `cdvirtualenv`
+ deactivate the environment when finished working

``` bash
$ mkvirtualenv myenvname
New python executable in /home/marcanuy/.virtualenvs/myenvname/bin/python
Installing setuptools, pip, wheel...done.
(myenvname)$ workon #the previous created env will appear listed, along the other envs
myenvname
(myenvname)$ cdvirtualenv myenvname #changes to the associated project directory
(myenvname)/opt/development/myproject$ cdsitepackages
(myenvname)~/.virtualenvs/myenvname/lib/python3.5/site-packages$ cdvirtualenv
(myenvname)/opt/development/myproject$ deactivate #finish work
/opt/development/myproject$
```

To create a new environment having a requirements file and a specific python version: `mkvirtualenv -r requirements/local.txt -p /usr/bin/python3.5 myprojectname`

+ virtualenvwrapper <https://virtualenvwrapper.readthedocs.io>

## Pending

- <https://docs.python.org/3/library/venv.html>
- PEP 405 -- Python Virtual Environments <https://www.python.org/dev/peps/pep-0405>
