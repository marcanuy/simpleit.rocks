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

The development process of Django projects can have several environments, a common _deployment architecture_ consists of a [4-tier architecture], consisting of software being deployed to each _tier_ in the following order:

1. development (__DEV__)
2. testing (__TEST__)
3. staging (__STAGE__)
4. production (__PROD__) 

A default _Django app_ just starts with a single _config file_ located in `DJANGO_PROJECT/settings.py`. This approach is fine for small projects but to fit in the above 4-tier architecture, the project needs to be changed to address two main problems:

- each environment should have a __specific settings file__
- each environment should have __its own packages__

The configuration file should be version controlled, even the developers local configuration file, all the developers of a project should use the same development configuration.

However there are special config keys that should be left out of versioning, like the [SECRET_KEY](https://docs.djangoproject.com/en/1.9/ref/settings/#std:setting-SECRET_KEY) setting (used for [cryptographic signing functionalities](https://docs.djangoproject.com/en/1.9/topics/signing/))

The default _Config file_ that comes shipped with Django should be pulled apart into several settings for each environment: _local_, _staging_, _test_, _production_. This can be done easily inheriting from a _base config file_, changing what the specific environment needs and __[leaving secret keys outside config files versioning using environment variables](http://12factor.net/config)__.

If _virtualenvwrapper_ is being used, the default development settings parameter to work with _manage.py_ can be specified in the _postactivate_ hook: `echo "export DJANGO_SETTINGS_MODULE=settings.local" >> $VIRTUAL_ENV/bin/postactivate`
{: class="alert alert-warning"}

When using _manage.py_ many commands accepts the parameter to specify a specific settings file: `python manage.py runserver --settings=myproject.settings.local`

To compare the current settings file with the one that installs Django by default: `$ manage.py diffsettings`
{: class="alert alert-info"}

## Setting environment variables

In a __development__ environment, variables can be set with `$ export A_SECRET_KEY=shhh1234`, and placed in:

+ _.bashrc_ or _.profile_ 
+ _virtualenvwrapper's_ __bin/activate__ hook file

To check that the secret environment key is being loaded, it is possible to check it from a python shell:

``` python
import os
os.environ["A_SECRET_KEY"]
"shhh1234"
```

Then to get the value for a specific environment, the _production config
file_ in version control only needs to get this environment variable 
value: `A_SECRET_KEY = os.environ["A_SECRET_KEY"]`

In a __production__ environment like [Heroku](https://devcenter.heroku.com/articles/config-vars), 
this can be done with: `$ heroku config:set A_SECRET_KEY=shhh1234`
{: class="alert alert-info"}

## Splitting settings

Splitting the default Django's settings file into several files for
different environments.

Django automatically creates a configuration file in
`<project_name>/settings.py`, to break it up into _local_, _testing_,
_staging_ and _production_ config files, the best way is to create a
`base.py` config with common configurations accross all of them and 
create specific config files for each environment:

~~~
.
└── REPO-ROOT `git repo`
    ├── .gitignore
    ├── ...
    └── PROJECT-ROOT
        ├── settings
        |   ├── __init__.py
        |   ├── base.py
        |   └── local.py
        ├── manage.py
        └── ...
~~~

1. Create the settings directory `$ mkdir <project_name>/settings`
2. Add `__init__.py` file to make Python treat the settings directory as containing packages `$ touch <project_name>/settings/__init__.py`
3. Move the default settings file into the settings directory and change its name `$ mv <project_name>/settings.py <project_name>/settings/base.py`
4. Create all the configuration files (`local.py`, `testing.py`, `staging.py`, `production.py` ) and specify to inherit `base.py` configurations, for example, for the development file: `echo "from .base import *" >> <project_name>/settings/local.py`
5. Use the new settings file in one of two ways:
  - Configure the current environment to use the appropriate settings file, in development: `$ export DJANGO_SETTINGS_MODULE=mysite.settings.local` and then `djang-admin runserver` will use the above settings.
  - Use the `--settings` parameter: `django-admin runserver --settings=mysite.settings.local`

Django has two administrative scripts: `django_admin.py` and `manage.py` (that automatically configures the django instance with the current project).

One of the [differences](https://docs.djangoproject.com/en/1.9/ref/django-admin/) between them is that `manage.py` automatically configures the  [DJANGO_SETTINGS_MODULE](https://docs.djangoproject.com/en/1.9/topics/settings/#envvar-DJANGO_SETTINGS_MODULE) environment variable using the project's `settings.py`.
{: class="alert alert-warning"}

> Generally, when working on a single Django project, it’s easier to use manage.py than django-admin. 
> If you need to switch between multiple Django settings files, use django-admin with DJANGO_SETTINGS_MODULE or the --settings command line option.
{: cite="https://docs.djangoproject.com/en/1.9/ref/django-admin/"}

We start having a `settings.py` single file and break it up into a new
directory with specific environment settings:

<div class="mermaid">
graph LR
  A["settings.py"]
  B["settings/<br><br>base.py<br>local.py<br>testing.py<br>staging.py<br>production.py"]
  A-->B
</div>

## Packages for each environment

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
_base.txt_ requirement file using `pip`, each new file should begin with: `-r base.txt`

~~~ conf
# /requirements/base.txt
# list of packages present in all environments
~~~

~~~ conf
# /requirements/local.txt
-r base.txt
~~~

~~~ conf
# /requirements/test.txt
-r base.txt
~~~

~~~ conf
# /requirements/production.txt
-r base.txt
~~~


+ To generate a requirements file: [$ pip freeze](https://pip.pypa.io/en/stable/reference/pip_freeze/) `$ pip freeze --local > requirements/base.txt` 
+ To install the requirements file
  + in a local/development environment: `$ pip install -r requirements/local.txt`
  + in a testing environment: `$ pip install -r requirements/testing.txt`

## After

As with any major change to the default installation, after generating
these directories, it is a good practice to describe them in
`/docs/architectrure.rst` and what are the commands used to get them
running in `/docs/installation.rst` for other developers or just for
oneself when reviewing the project in the future.

## References

- Wikipedia [4-tier architecture]
- <https://docs.djangoproject.com/en/1.9/topics/settings/>
- <https://docs.djangoproject.com/en/1.9/ref/settings/>

[4-tier architecture]: <https://en.wikipedia.org/wiki/Deployment_environment>
[python virtual environment]: <{% link docs/python/language/environment/_posts/2016-06-10-python-virtual-environments-using-virtualenv.md %}>
