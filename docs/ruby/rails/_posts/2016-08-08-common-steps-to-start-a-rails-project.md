---
title: 
subtitle:
slug: 
layout: post
tags:
- ruby-on-rails
- web-development
description: > # Under 140 char. Used for meta description and main description
  Basic steps to start a rails app that will be hosted in a remote server and
  heroku, using sqlite3 in development and PostgreSQL in Heroku
---

## Overview

Basic steps to start a rails app that will be hosted in a remote server and
heroku, using sqlite3 in development and PostgreSQL in production (heroku).

## Generate a new app

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>rails _5.0.0_ new sample_app</kbd>
</samp>
</pre>

## Adjust Gemfile

Inspect `/sample_app/Gemfile` and put `sqlite3` in the `development` group
and `postgresql` in `production` group.

~~~ ruby
#...
group :development, :test do
  gem 'sqlite3', '1.3.11'
  #...
end

group :production do
  gem 'pg', '0.18.4'
end

~~~

## Install gems

Install the gems specified in `development`, skipping `production` gems with <kbd>bundle install --without production</kbd>.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>cd sample_app</kbd>
<span class="shell-prompt">sample_app$</span> <kbd>bundle install --without production</kbd>
<span class="shell-prompt">sample_app$</span> <kbd>bundle update</kbd>
</samp>
</pre>

## Initialize Git repository

Start control versioning the project

<pre class="shell">
<samp>
<span class="shell-prompt">sample_app$</span> <kbd>git init</kbd>
<span class="shell-prompt">sample_app$</span> <kbd> git commit -m "Init repo"</kbd>
</samp>
</pre>

## Add Github repo

Set a new remote to [github](https://help.github.com/articles/adding-a-remote/)

<pre class="shell">
<samp>
<span class="shell-prompt">sample_app$</span> <kbd>git remote add origin https://github.com/user/sample_app.git</kbd>
<span class="shell-prompt">sample_app$</span> <kbd>git push -u origin --all</kbd>
</samp>
</pre>


## Deploy to Heroku

Pushing and deploying the application to Heroku.

<pre class="shell">
<samp>
<span class="shell-prompt">sample_app$</span> <kbd>heroku create</kbd>
<span class="shell-prompt">sample_app$</span> <kbd>git push heroku master</kbd>
</samp>
</pre>

## Useful commands

Migrating the database.

<pre class="shell">
<samp>
<span class="shell-prompt">sample_app$</span> <kbd>rails db:migrate</kbd>
</samp>
</pre>

Running the test suite to verify that everything is working.

<pre class="shell">
<samp>
<span class="shell-prompt">sample_app$</span> <kbd>rails test</kbd>
</samp>
</pre>

Run the app in a local server:

<pre class="shell">
<samp>
<span class="shell-prompt">sample_app$</span> <kbd>rails server</kbd>
</samp>
</pre>

