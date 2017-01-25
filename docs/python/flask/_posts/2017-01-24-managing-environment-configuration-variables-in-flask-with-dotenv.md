---
description: How to manage environment variables for a specific app using dotenv.
tags: 
---

## Overview

Often when developing apps with Flask we need to set up environment
variables to keep sensitive information secure and out of version
control. 

This article describes how to set up environment config variables in
Flask with *python-dotenv* and why we can't rely in Flask' instance
folder.

## dotenv versus instance folders

Flask introduces the concept of **instance folder**, designed to store
sensitive information like credentials and passwords for your local
environment, the main problem is that
[it can't work with ephemeral filesystems]({% link /docs/python/flask/_posts/2017-01-24-avoid-using-flask-instance-folder-when-deploying-to-heroku.md %}) like
the one Heroku uses.

In this case the perfect fit for this is to use python-dotenv, so we
define environment config variables in Heroku and locally we put them
in `/.env`.

## Install

First we install it with <kbd>pip install -U python-dotenv</kbd>

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd></kbd>
Collecting python-dotenv
  Downloading python-dotenv-0.6.2.tar.gz
Collecting click>=5.0 (from python-dotenv)
  Downloading click-6.7-py2.py3-none-any.whl (71kB)
    100% |████████████████████████████████| 71kB 756kB/s 
Building wheels for collected packages: python-dotenv
  Running setup.py bdist_wheel for python-dotenv ... done
  Stored in directory: /home/user/.cache/pip/wheels/07/08/3a/7591582130baac86479ca3b7cb6314c9878e877645267d25c9
Successfully built python-dotenv
Installing collected packages: click, python-dotenv
  Found existing installation: click 6.6
    Uninstalling click-6.6:
      Successfully uninstalled click-6.6
Successfully installed click-6.7 python-dotenv-0.6.2
</samp>
</pre>

## requirements.txt

We add the new package to the requirements file.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>pip freeze > requirements.txt</kbd>
</samp>
</pre>

## gitignore

We make sure that we won't add it to the source code version control
adding it to `.gitignore`:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>echo ".env" >> .gitignore</kbd>
</samp>
</pre>

## add variables

Add variables to `.env`, optionally copy all the environment variables
from your heroku app to have this as a skeleton to fill with local
variables:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>heroku config -s >> .env</kbd>
</samp>
</pre>

-s, --shell         # output config vars in shell format
{: class="alert alert-info"}

or simply add them manually to `.env`, for example:

~~~
TWITTER_CONSUMER_KEY=MYINCREDIBLEKEY
~~~

## use the new environment variables

Now we can use this environment variables in our Flask app.

Having the following typical structure:

~~~
myapp
	.env
	myapp
		__init__.py
		myapp.py
~~~

I like to initialize my app in `/myapp/__init.py__`, but it should be
the same if you add this to `/myapp/myapp.py`.

~~~ python
import os
from flask import Flask
from dotenv import load_dotenv
#...

# load dotenv in the base root
APP_ROOT = os.path.join(os.path.dirname(__file__), '..')   # refers to application_top
dotenv_path = os.path.join(APP_ROOT, '.env')
load_dotenv(dotenv_path)

tw_consumer_key = os.getenv('TWITTER_CONSUMER_KEY')
~~~

## Conclusion

I find it useful to use `dotenv` for sensitive variables and custom
 paths, and [maintain other variables in version control separated by
 server, like development, testing or production]({% link /docs/python/flask/_posts/2017-01-11-organize-a-flask-project-to-handle-production-and-development-environments-effectively.md %}).
