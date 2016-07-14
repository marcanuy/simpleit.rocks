---
title: Django Configuration and environment isolation
subtitle: Having a different configuration for development, staging and production servers
---

Every config file should be version controlled, even the developers local configuration, all the developers of a project should use the same development configuration. 

However there are special config keys that should be left out of versioning, like the [SECRET_KEY](https://docs.djangoproject.com/en/1.9/ref/settings/#std:setting-SECRET_KEY) setting (used for [cryptographic signing functionalities](https://docs.djangoproject.com/en/1.9/topics/signing/))

The default _Config file_ that comes shipped with Django should be pulled apart into several settings for each environment: _local_, _staging_, _test_, _production_. This can be done easily inheriting from a _base config file_, changing what the specific environment needs and __[leaving secret keys outside config files versioning using environment variables](http://12factor.net/config)__.

If _virtualenvwrapper_ is being used, the default development settings parameter to work with _manage.py_ can be specified in the _postactivate_ hook: `echo "export DJANGO_SETTINGS_MODULE=settings.local" >> $VIRTUAL_ENV/bin/postactivate`

When using _manage.py_ many commands accepts the parameter to specify a specific settings file: `python manage.py runserver --settings=myproject.settings.local`

+ To compare the current settings file with the one that installs Django by default: `$ manage.py diffsettings`

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

Then to get the value for a specific environment, the _production config file_ in version control only needs to get this environment variable value: `A_SECRET_KEY = os.environ["A_SECRET_KEY"]`

In a __production__ environment like [Heroku](https://devcenter.heroku.com/articles/config-vars), this can be done with: `$ heroku config:set A_SECRET_KEY=shhh1234`

## Splitting the default Django's settings file into several files for different environments

Django automatically creates a configuration file in `<project_name>/settings.py`, to break it up into _local_, _testing_, _staging_ and _production_ config files, the best way is to create a `base.py` config with common configurations accross all of them and leave:

1. Create the settings directory `$ mkdir <project_name>/settings`
2. Add `__init__.py` file to make Python treat the settings directory as containing packages `$ touch <project_name>/settings/__init__.py`
3. Move the default settings file into the settings directory and change its name `$ mv <project_name>/settings.py <project_name>/settings/base.py`
4. Create all the configuration files (_local.py_, _testing.py_, _staging_, _production_ ) and specify to inherit _base.py_ configurations, for example, for the development file: `echo "from .base import *" >> <project_name>/settings/local.py`
5. Configure the current environment to use the appropriate settings file, in development: `$ export DJANGO_SETTINGS_MODULE=mysite.settings.local`

Django has two administrative scripts: __django_admin.py__ and __manage.py__ (that automatically configures the django instance with the current project). 
One of the [differences](https://docs.djangoproject.com/en/1.9/ref/django-admin/) between them is that _manage.py_ automatically configures the  __DJANGO_SETTINGS_MODULE__ environment variable using the project's _settings.py_.

> Generally, when working on a single Django project, it’s easier to use manage.py than django-admin. 
> If you need to switch between multiple Django settings files, use django-admin with DJANGO_SETTINGS_MODULE or the --settings command line option.
{: cite="https://docs.djangoproject.com/en/1.9/ref/django-admin/"}

## Packages for each environment

Each environment needs a specific requirements file, having a _base.txt_ requirement file with common packages across environments and then adding the needed packages for each environment.

Common commands:

+ To make it possible for each environment to inherit the packages from the _base.txt_ requirement file, each new file should begin with: `-r base.txt`
+ To generate a requirements file: [$ pip freeze](https://pip.pypa.io/en/stable/reference/pip_freeze/) `$ pip freeze --local > requirements/base.txt` 
+ To install the requirements file in a local environment: `$ pip install -r requirements/base.txt`

