---
title: Django Configuration and environment isolation
subtitle: Having a different configuration for development, staging and production servers
description: Configure a Django project to handle multiple environments, creating different settings and handling packages for each one.
weight: 2
layout: tutorial
current: > # Current status 
  graph TB
      subgraph Django Project
          conf["settings.py"]
          pack[packages]
      end
      conf==>dev[Development Environment]
      pack==>dev
      conf==>prod[Production Server]
      pack==>prod
goal: > # Goal graph
  graph LR
      subgraph Production Server
          prod_conf["production_settings.py"]
          prod_pack["Production Server Packages"]
      end
      subgraph Development Environment
          dev_conf["development_settings.py"]
          dev_pack["Developer Environment Packages"]
      end
flow: > # Process flow graph
  graph TB
      env["Set environment variables"]
      env==>split["Split settings.py into separated files <br> with custom settings for each environment"]
      split==>pack["Configure different Packages for each environment"]
---

## Overview 

Django projects should have several environments each with its own
peculiarities. Each environment is optimized for a specific task,
e.g.: develop your app, having packages that helps you test it,
another with all the security measures for production, and so on.

In this guide we will split the standard settings file into specific
settings optimized for each environment.

## Four tier architecture

A common _deployment architecture_ consists of a [4-tier
architecture], having different settings for one of these _tiers_:

1. development (__DEV__)
2. testing (__TEST__)
3. staging (__STAGE__)
4. production (__PROD__) 

A default _Django app_ just starts with a single _configuration file_
located in `DJANGO_PROJECT/settings.py`. This approach is fine for
small projects but to fit in the above 4-tier architecture, the
project needs to be changed to address two main problems:

- each environment should have a __specific settings file__
- each environment should have __its own packages__

## Config files and version control

The configuration file should be tracked in version control, even
developers local configuration file, all the developers of a project
should use the same development configuration.
{: .alert .alert-info}

However there are special config keys that should be left out of
versioning, like the
[SECRET_KEY](https://docs.djangoproject.com/en/2.0/ref/settings/#std:setting-SECRET_KEY)
setting (used for [cryptographic signing
functionalities](https://docs.djangoproject.com/en/2.0/topics/signing/)).

## Splitting settings description

The default _Config file_ that comes shipped with Django should be
pulled apart into several settings for each environment: _local_,
_staging_, _test_, _production_. 

This can be done easily inheriting from a _base config file_, changing
what the specific environment needs and **leaving secret keys outside
config files versioning using environment
variables** as recommended by <http://12factor.net/config>.

### Using different settings

You can specify which setting file to use via one of these methods:

Variables can be set with environment variables e.g.: <kbd>export
A_SECRET_KEY=foobar1234</kbd>
 `$ export A_SECRET_KEY=shhh1234`, and placed in:

+ _.bashrc_ or _.profile_ 
+ _virtualenvwrapper's_ __bin/activate__ hook file

#### Virtualenv post hook

If _virtualenvwrapper_ is being used, the default development settings
parameter to work with _manage.py_ can be specified in the
_postactivate_ hook: `echo "export
DJANGO_SETTINGS_MODULE=settings.local" >>
$VIRTUAL_ENV/bin/postactivate` 
{: class="alert alert-warning"}

#### Manage.py parameter

When using _manage.py_ many commands accepts the parameter to specify
a specific settings file: `python manage.py runserver
--settings=myproject.settings.local`

There is a handy manage.py parameter to compare the current settings
file with the one that installs Django by default: `$ manage.py
diffsettings` so you can see what you have changed from the original
settings file so far. 
{: class="alert alert-info"}

### Checking settings environment variables

To check that the secret environment key is being loaded, it is possible to check it from a python shell:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>./manage.py shell</kbd>
Python 3.6.4 (default, Feb  5 2018, 16:52:44) 
[GCC 7.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
(InteractiveConsole)
<span class="shell-prompt">>>></span> <kbd>import os</kbd>
<span class="shell-prompt">>>></span> <kbd>os.environ["A_SECRET_KEY"]</kbd>
"shhh1234"
</samp>
</pre>

Then to get the value for a specific environment, the _production config
file_ in version control only needs to get this environment variable 
value: `A_SECRET_KEY = os.environ["A_SECRET_KEY"]`

In a __production__ environment like [Heroku](https://devcenter.heroku.com/articles/config-vars), 
this can be done with: `$ heroku config:set A_SECRET_KEY=shhh1234`
{: class="alert alert-info"}

## Creating different settings files

When building a project, Django automatically creates a configuration
file in `<project_name>/settings.py`. 

To split this file into multiple settings files (one for each
environment _local_, _testing_, _staging_ and _production_), the best
way is to create a `base.py` config with common settings across all of
them and create specific config files for each environment in specific
files having a structure like:

~~~
.
└── REPO-ROOT `git repo`
    ├── ...
    └── PROJECT-ROOT
        ├── settings
        |   ├── __init__.py
        |   ├── base.py
        |   └── local.py
        ├── manage.py
        └── ...
~~~

To build this structure:

1. Create the settings directory

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>mkdir PROJECT_NAME/settings</kbd>

</samp>
</pre>

2. Add `__init__.py` file to make this directory a Python package

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>touch PROJECT_NAME/settings/__init__.py</kbd>
</samp>
</pre>
   
3. Move the default settings file into the new settings directory and
   change its name 
   
<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>mv PROJECT_NAME/settings.py PROJECT_NAME/settings/base.py</kbd>

</samp>
</pre>

4. Create all the configuration files (`local.py`, `testing.py`,
   `staging.py`, `production.py` ) and specify to inherit `base.py`
   configurations adding `from .base import *` to each file: 

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>for name in local.py testing.py staging.py production.py; do echo "from .base import *" >> PROJECT_NAME/settings/${name} ; done</kbd>
</samp>
</pre>

   
5. Use the new settings file in one of previously described ways: 
  - set an environment variable and call scripts normally
  - call scripts specifying a settings file
    
### Set environment variables

Configure the current environment to use the appropriate settings file, using [PYTHONPATH](https://docs.python.org/3/using/cmdline.html#envvar-PYTHONPATH) and [DJANGO_SETTINGS_MODULE](https://docs.djangoproject.com/en/1.9/topics/settings/#envvar-DJANGO_SETTINGS_MODULE):
  
  <pre class="shell"> 
  <samp>
  <span class="shell-prompt">$</span> <kbd>export DJANGO_SETTINGS_MODULE=mysite.settings.local</kbd>
  <span class="shell-prompt">$</span> <kbd>export PYTHONPATH=~/path/to/my/project</kbd>
  <span class="shell-comment">#django-admin will use the above settings by default</span>
  <span class="shell-prompt">$</span> <kbd>django-admin runserver</kbd>
  </samp>
  </pre>

### Specify settings as a parameter
  
Use the `--settings` parameter with `manage.py` or `django-admin`:

<pre class="shell"> 
<samp>
<span class="shell-prompt">$</span> <kbd>django-admin runserver --settings=mysite.settings.local --pythonpath=/path/to/my/project</kbd>
Performing system checks...

System check identified no issues (0 silenced).

July 23, 2016 - 22:43:48
Django version 1.9.6, using settings 'mysite.settings.local'
Starting development server at http://127.0.0.1:8000/
Quit the server with CONTROL-C.
</samp>
</pre>

### Differences between manage.py and django-admin

Django has two administrative scripts: `django_admin.py` and `manage.py` (in the root of each Django project).

__`manage.py` is a wrapper of `django-admin`__, the only [difference](https://docs.djangoproject.com/en/1.9/ref/django-admin/) between them is that `manage.py` sets the [DJANGO_SETTINGS_MODULE](https://docs.djangoproject.com/en/1.9/topics/settings/#envvar-DJANGO_SETTINGS_MODULE) environment variable to `settings.py` by default, if not changed.
{: class="alert alert-warning"}

So with the about settings scheme, it is better to use `django-admin` and choose the proper settings file.

> Generally, when working on a single Django project, it’s easier to
> use manage.py than django-admin.  If you need to switch between
> multiple Django settings files, use django-admin with
> **DJANGO_SETTINGS_MODULE** or the **--settings** command line
> option.
> 
> <footer class="blockquote-footer"> <cite><a href="https://docs.djangoproject.com/en/1.9/ref/django-admin/">Django Docs</a></cite></footer>
{: class="blockquote" cite="https://docs.djangoproject.com/en/1.9/ref/django-admin/"}

### Summary

We started having a `settings.py` single file and break it up into a new
directory with specific environment settings:

<div class="mermaid">
graph LR
  A["settings.py"]
  B["settings/<br><br>base.py<br>local.py<br>testing.py<br>staging.py<br>production.py"]
  A-->B
</div>

## Packages for each environment

Now a similar approach for handling package dependencies.

Each environment has to have a set of packages that fits its
purpose and operating system requirements. We have to 
configure a [python virtual environment] so it is possible to install
packages in _development_, that are not needed in production and viceversa,
or that can be installed in different Operating Systems.

Each environment needs a specific file, having a _base.txt_ requirement
file with common packages across environments and then adding
the needed packages for each environment.

~~~
.
└── REPO-ROOT `git repo`
    ├── .gitignore
    ├── requirements
    |   ├── base.txt
    |   ├── local.txt
    |   ├── production.txt
    |   └── test.txt
    ├── ...
    └── PROJECT-ROOT
        ├── manage.py
        └── ...
~~~

Using `pip` it is possible to specify which file has the list of
packages you want:

~~~
pip install [options] -r <requirements file> [package-index-options] ...
  -r, --requirement <file>    Install from the given requirements file. This option can be used multiple times.
~~~
  
So to make it possible for each environment to inherit the packages from the
_base.txt_ requirement file using `pip`, each new file should begin with: `-r base.txt`:

`/requirements/base.txt`:
~~~ conf
# list of packages present in all environments
~~~

`/requirements/local.txt`:
~~~ conf
-r base.txt
~~~

`/requirements/test.txt`:
~~~ conf
-r base.txt
~~~

`/requirements/production.txt`:
~~~ conf
-r base.txt
~~~


+ To generate a requirements file: [$ pip freeze](https://pip.pypa.io/en/stable/reference/pip_freeze/) `$ pip freeze --local > requirements/base.txt` 
+ To install the requirements file
  + in a local/development environment: `$ pip install -r requirements/local.txt`
  + in a testing environment: `$ pip install -r requirements/testing.txt`

## After

As with any major change to the default installation, after generating
these directories, it is a good practice to describe them in
`/docs/architecture.rst` and what are the commands used to get them
running in `/docs/installation.rst` for other developers or just for
oneself when reviewing the project in the future.

## References

- Wikipedia [4-tier architecture]
- <https://docs.djangoproject.com/en/1.9/topics/settings/>
- <https://docs.djangoproject.com/en/1.9/ref/settings/>

[4-tier architecture]: <https://en.wikipedia.org/wiki/Deployment_environment>
[python virtual environment]: <{% link docs/python/language/environment/_posts/2016-06-10-python-virtual-environments-using-virtualenv.md %}>
