---
title: An Overview Of Flask Main Concepts And How It Works
subtitle: Framework basic summary
description: Flask Python Web framework overview
layout: post
---

## Overview

Flask is one of the Python's most popular web frameworks. This is an
overview of its main concepts to get started quickly and understand
how it works.

> Flask is a microframework for Python based on Werkzeug, Jinja 2 and
> good intentions.
> 
> <footer class="blockquote-footer"> <cite>Slogan at <a href="http://flask.pocoo.org/">Flask homepage</a></cite></footer>
{: class="blockquote" cite="http://flask.pocoo.org/"}

## Flask script

Flask, like most modern frameworks, has its own command `flask` to
perform tasks. 

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>flask --help</kbd>
Usage: flask [OPTIONS] COMMAND [ARGS]...

  This shell command acts as general utility script for Flask applications.

  It loads the application configured (through the FLASK_APP environment
  variable) and then provides commands either provided by the application or
  Flask itself.

  The most useful commands are the "run" and "shell" command.

  Example usage:

    $ export FLASK_APP=hello.py
    $ export FLASK_DEBUG=1
    $ flask run

Options:
  --version  Show the flask version
  --help     Show this message and exit.

Commands:
  run    Runs a development server.
  shell  Runs a shell in the app context.
</samp>
</pre>

Every Flask application you create is an instance of the
`flask.Flask` class. The flask object implements a [WSGI] application
and acts as the central object.

The `flask.Flask` class is responsible for handling all the
**view functions**, **URLs routing** and **templates setup**, so in a
simple app, you will end up having a single file.

To create a Flask app, we instantiate `flask.Flask` in our main module
or in the `__init__.py` file of the package like:

~~~ python
from flask import Flask
app = Flask(__name__)
~~~

The first parameter tells Flask what belongs to this app, if you are
using a single module, then `__name__` is enough, but if not then you
should specify the name of the package or module you are using to help
Flask to find resources, improve debugging information, etc.

This is what a typical Flask app skeleton looks like:

~~~ python
# -*- coding: utf-8 -*-
from flask import Flask

# create application
app = Flask(__name__)

# Load default config and override config from an environment variable
app.config 

# db management

# routes and views
@app.route('/')
def show_a_url():
     return render_template('show_me.html', ..)

# local server running
if __name__ == '__main__':
	app.run()
~~~

### Configuration

`flask.Flask.config` or likely `app.config` contains the configuration
dictionary, it is an instance of `config.Config`
from
[dict](https://docs.python.org/3/library/stdtypes.html#mapping-types-dict) behaving
like a
common
[Python dictionary](https://docs.python.org/3/tutorial/datastructures.html#dictionaries) but
supports additional methods to load a configurations from special dictionaries
and files.

See also: [How to configure Flask to have different configuration files in production and development environments]({% link docs/python/flask/_posts/2017-01-11-organize-a-flask-project-to-handle-production-and-development-environments-effectively.md %})
{: class="alert alert-success"}

#### Populating the Configuration

The `config.Config` allows us to populate the configuration dictionary
in several ways.

A common pattern for simple apps that don't need to have
configurations for multiple environments is to load the configuration
from the `yourapplication.default_settings` module and then override
the values with the contents of the file the
`YOURAPPLICATION_SETTINGS` environment variable points to:

~~~ python
app = Flask(__name__)
app.config.from_object('yourapplication.default_settings')
app.config.from_envvar('YOURAPPLICATION_SETTINGS')
~~~

And then setup the environment variable with <kbd>$ export
YOURAPPLICATION_SETTINGS=/path/to/settings.cfg</kbd>.

The available methods include:

#### dict keys

Defining or updating new configurations like a normal dicttionary

  ~~~ python
  app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
  # many keys at once
  app.config.update(
    DEBUG=True,
    SECRET_KEY='...'
  )
  ~~~

#### Files

Configuration can be stored in Python files with values in
*uppercase*. 

~~~
DEBUG = False
SECRET_KEY = '?\xbf,\xb4\x8d\xa3"<\x9c\xb0@\x0f5\xab,w\xee\x8d$0\x13\x8b83'
~~~
 
#### Python files

Creating a configuration in a Python file and loading it:

  ~~~ python
  app.config.from_pyfile('yourconfig.cfg')
  ~~~

- load configuration from an environment variable pointing to a file

  <pre class="shell">
  <samp>
  <span class="shell-prompt">$</span> <kbd>export YOURAPPLICATION_SETTINGS='/path/to/config/file'</kbd>
  </samp>
  </pre>
  
  Then in your code, load it using `config.Config.from_envvar`:

  ~~~ python
  app.config.from_envvar('YOURAPPLICATION_SETTINGS')
  ~~~

  This is the same of doing
  `app.config.from_pyfile(os.environ['YOURAPPLICATION_SETTINGS'])`
  with a nicer error message
  {: class="alert alert-info"}

#### Objects

Define configuration variables and add them with the `from_object`
  method, updating the vales of each variable:
  
  ~~~ python
  DEBUG = True
  SECRET_KEY = 'development key'
  app.config.from_object(__name__)
  ~~~

#### Others

- From a `json` file with `config.Config.from_json`.
- from mappings: `config.Config.from_mapping`

## Development server

Flask comes with a development server to debug and test your app
locally, it shouldn't be used in a production environment mainly because two reasons:

- it doesn’t scale well and
- serves only one request at a time

The <kbd>flask run</kbd> command will end up calling
`flask.Flask.run()`, this will always start a local [WSGI], so you
need to make sure it is located in the block executed when running
python scripts like `if __name__ == '__main__': `, to avoid executing
it when serving your app in another web server.

The `flask` command depends on the `FLASK_APP` environment
variable to know which app to work on, we start specifying this with
the `export` command, then if we run the flask development server it
knows which file to refer to:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>export FLASK_APP=hello.py</kbd>
<span class="shell-prompt">$</span> <kbd>flask run</kbd>
 * Running on http://127.0.0.1:5000/
</samp>
</pre>

### Reload server when code changes

There is a special debug mode handled by the `FLASK_DEBUG` environment
variable that allows to:

- reload the server automatically each time the code changes
- output debugging information on errors

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>export FLASK_DEBUG=1</kbd>
<span class="shell-prompt">$</span> <kbd>flask run</kbd>
 * Forcing debug mode on
 * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
 * Restarting with stat
 * Debugger is active!
 * Debugger pin code: 292-824-230
</samp>
</pre>

## Routing

Routing is done binding functions with URLs, using the [route()](http://flask.pocoo.org/docs/0.12/api/#flask.Flask.route)
decorator.

For example, the URL `/hello-world` would run the `hello()` function:

~~~ python
@app.route('/hello-world')
def hello():
    return 'Hello World'
~~~

### Dynamic URLs

Flask URLs can also handle variables specifying them like
`<variable_name>` or more precisely using *converters*
`<converter:variable_name>` like `'/post/<int:post_id>'`.

~~~
@app.route('/user/<username>')
def show_user_profile(username):
    # show the user profile for that user
    return 'User %s' % username
~~~

### Reverse URLs

Generating URLs knowing the function name is also possible
with [url_for](http://flask.pocoo.org/docs/0.12/api/#flask.url_for)
like:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>python</kbd>
Python 3.5.2+ (default, Sep 22 2016, 12:18:14) 
[GCC 6.2.0 20160927] on linux
Type "help", "copyright", "credits" or "license" for more information.
<span class="shell-prompt">>>> </span> <kbd>from flask import Flask, url_for</kbd>
<span class="shell-prompt">>>> </span> <kbd>app = Flask(__name__)</kbd>
<span class="shell-prompt">>>> </span> <kbd>@app.route('/login')</kbd>
<span class="shell-prompt">... </span> <kbd>def login(): pass</kbd>
<span class="shell-prompt">... </span> <kbd></kbd>
<span class="shell-prompt">>>> </span> <kbd>with app.test_request_context():</kbd>
<span class="shell-prompt">... </span> <kbd>    print(url_for('login', next='/'))</kbd>
<span class="shell-prompt">... </span> <kbd></kbd>
/login?next=%2F
<span class="shell-prompt">>>> </span>
</samp>
</pre>

[test_request_context()](http://flask.pocoo.org/docs/0.12/api/#flask.Flask.test_request_context) method
tells Flask to behave like handling a request, even though
we are using a Python shell.
{: class="alert alert-info"}


~~~ python
from flask import Flask, url_for
>>> app = Flask(__name__)
>>> @app.route('/login')
... def login(): pass
...
>>> with app.test_request_context():
...  print url_for('login', next='/')
~~~

## Basic project structure

Flask applications are recommended to be installed and run as Python
packages.


~~~
/myproject
    /myproject
		__init__.py  ## make the project a package
		myproject.py ## application module
		schema.sql   ## SQLite3 database
        /static      ## static files like js and css; var: `static_folder`
        /templates   ## jinja2 templates; var: `template_folder`
    /tests
        test_myproject.py
    setup.py     ## Setuptools packaging
    MANIFEST.in
~~~

## References

- Official docs <http://flask.pocoo.org/>
- Routing <http://flask.pocoo.org/docs/0.12/api/#flask.Flask.route>
- Tutorial folder <http://flask.pocoo.org/docs/0.12/tutorial/folders/#tutorial-folders>
- Explore flask book <http://explore-flask.readthedocs.io/en/latest/configuration.html>

*[WSGI]: Web Server Gateway Interface
