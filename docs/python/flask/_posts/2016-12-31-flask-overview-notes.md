---
title: Flask Overview
subtitle: Framework basic summary
description: Flask Python Web framework overview
layout: post
---

## Overview

Flask is one of the most popular web frameworks in Github. This is an
overview of its main concepts to get started quickly.

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

## Development server

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
        /static      ## static files like js and css
        /templates   ## jinja2 templates
	/tests
		test_myproject.py
	setup.py     ## Setuptools packaging
    MANIFEST.in
~~~

## References

- Official docs <http://flask.pocoo.org/>
- Routing <http://flask.pocoo.org/docs/0.12/api/#flask.Flask.route>
- Tutorial folder <http://flask.pocoo.org/docs/0.12/tutorial/folders/#tutorial-folders>
