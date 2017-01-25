---
description: How to configure Flask to handle different configuration files based on environment variables. Having specific configuration files for production and development.
layout: post
---

## Separated configurations for Development and Production

In most situations, applications would need different configurations
for each environment: Production, Staging, Development, etc.

## Load default config and an environment specific one

The easiest way to have multiple configurations is to:

- use a default configuration that is always loaded and 
- the default configuration is under version control (e.g.: part of the *git* project repo) and
- Use an environment variable to switch between the configurations that overrides the values as needed in each environment
  
Example:

Having a configuration that loads configuration values from the
specified *config* environment `YOURAPPLICATION_SETTINGS`:

~~~python
app = Flask(__name__)
app.config.from_object('yourapplication.default_settings')
app.config.from_envvar('YOURAPPLICATION_SETTINGS')
~~~

Then we create a separate config.py for each *env* and export the
configuration path:

<pre class="shell">
<span class="shell-prompt">$</span> <kbd>export
YOURAPPLICATION_SETTINGS=/path/to/config.py</kbd>
</pre>


This way it will always load the default *configs* and then our custom
variables from `YOURAPPLICATION_SETTINGS`.

## Instance paths

From Flask 0.8, there is the concept of **instance folders**. The
instance folder is a good fit for configuration files because it is
designed to **not be under version control** and **be deployment specific**. 

To keep the *instance* folder out of versioning in *Git* add `instance/`
to `/.gitignore`.
{: class="alert alert-info"}

By default, Flask looks for a folder named `instance` in the same
level of your main file or the package.

## Behaviour

Using this folder and having environment specific configuration files
in the `config` folder we end up having the following directory structure:

~~~
...
config/
  __init__.py
  default.py
  development.py
  production.py
instance/
  config.py
myapp/
  __init__.py
  myapp.py
  ..
~~~

To have the configurations loaded we have to:

- load the default config in `config/default.py` 
- load configuration from instance folder  `instance/config.py`
- Load the file specified by the `APP_CONFIG_FILE` environment
  variable

In `myapp/__init__.py` we load them:

~~~ python
# myapp/__init__.py

app = Flask(__name__, instance_relative_config=True)
app.config.from_object('config.default')
app.config.from_pyfile('config.py')
app.config.from_envvar('APP_CONFIG_FILE')
~~~

Then set the environment variable depending on the server we are
invoking the app:

<pre class="shell">
<span class="shell-prompt">$</span> <kbd>export APP_CONFIG_FILE=/var/www/yourapp/config/production.py</kbd>
</pre>

## Final

Now your folder structure should look like:

~~~
myapp
├── config
│   ├── __init__.py     # empty
│   ├── development.py
│   ├── default.py
│   └── production.py
├── instance
│   └── config.py
└── myapp
   ├── __init__.py
   └── myapp.py
~~~

It can be useful to also add support for `dotenv` to [handle sensitive
variables when deploying to Heroku]({% link docs/python/flask/_posts/2017-01-24-managing-environment-configuration-variables-in-flask-with-dotenv.md %}).

## References

- Explore flask book <http://explore-flask.readthedocs.io/en/latest/configuration.html>
- [Non existing path when setting up Flask to have separated configurations for each environment](http://stackoverflow.com/q/41615662/1165509)
