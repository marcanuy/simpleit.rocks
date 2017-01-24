---
description: 
tags: heroku, deployment, web-development
---

## Overview

Flask framework comes with an elegant solution to store credentials
and sensitive information, it is the usage of **instance
folders**. Unfortunately this approach would have not sense if you
plan to deploy your *webapp* to Heroku, **flask's instance folder is
not compatible with Heroku** because the nature of its filesystem,
that is, the way the files are organized on the disk.

## Instance folders problem

From Flask 0.8, [instance folders][1] are the recommended way to store
sensitive information:

> designed to not be under version control and be deployment specific.
>
> It’s the perfect place to drop things that either change at runtime or
> configuration files.

But if you deploy to Heroku, its *Dynos* are cycled every 24 hours due
to its [ephemereal system][2]. As the project's instance folder would
be out of version control, if you
can
[somehow copy it to Heroku](http://stackoverflow.com/q/27761986/1165509),
it will disappear after some time.

> A dyno is a lightweight Linux container that runs a single
> user-specified command. Each dyno gets its own ephemeral filesystem,
> with a fresh copy of the most recently deployed code, any files
> written will be discarded the moment the dyno is stopped or
> restarted
{: class="alert alert-info"}

So the only solution to set all the sensitive information in
production is to set each environment variable, one by one, without
the possibility to drop all your sensitive environment variables in a
*config* file in the instance folder.

## Alternative: use a local .env file

To view all of your Flask app’s config vars, you can use <kbd>heroku config</kbd>.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> heroku config<kbd></kbd>
=== myapp-1234 Config Vars
APP_CONFIG_FILE:                /app/config.py
DATABASE_URL:                   postgres://asldfkjwg:2152134jsdfj23i5234j@ec2-194-32-16.compute-2.amazonaws.com:2232/aslkdgjsadj234
</samp>
</pre>

Then you can create the same variables for your local environment with
<kbd>$ heroku config:get CONFIG-VAR-NAME -s  >> .env</kbd>. 

After adding `.env` to `.gitignore` to avoid committing your local
environment variables, you can customize them locally and add
`.env` support to your flask apps in development and deployments with
the `python-dotenv`
package: <https://github.com/theskumar/python-dotenv>.

This way we achieve a strict **separation of config from code**, which
complies with twelve-factor's third statement: 
[Store config in the environment](https://12factor.net/config)


## References

- <http://flask.pocoo.org/docs/0.12/config/#instance-folders>
- <https://devcenter.heroku.com/articles/dynos>
- <https://12factor.net/config>

[1]: http://flask.pocoo.org/docs/0.12/config/#instance-folders
[2]: https://devcenter.heroku.com/articles/dynos#ephemeral-filesystem

*[filesystems]: A filesystem is the methods and data structures that an operating system uses to keep track of files on a disk or partition

