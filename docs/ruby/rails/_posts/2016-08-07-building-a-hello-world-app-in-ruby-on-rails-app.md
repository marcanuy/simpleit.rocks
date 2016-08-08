---
title: 
subtitle:
slug: 
layout: post
tags:
- ror
- rails
- web-development
description: > # Under 140 char. Used for meta description and main description
  Basic steps to start with Ruby on Rails.  
---

## Installing Rails

Using the _RubyGems_ package manager, we can install all __rails__ 
dependencies with one command.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>sudo gem install rails -v 5.0.0</kbd>
...
29 gems installed
</samp>
</pre>

_-v_ specify Rails version to install, in this case: 5.0.0
{: class="alert alert-warning"}

## Create the rails app structure

Using `rails new` command creates the skeleton for each rails app.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>mkdir rails_helloworld</kbd>
<span class="shell-prompt">$</span> <kbd>cd rails_helloworld</kbd>
<span class="shell-prompt">rails_helloworld$</span> <kbd>rails _5.0.0_ new hello_app</kbd>
      create  
      create  README.md
      create  Rakefile
      create  config.ru
      create  .gitignore
      create  Gemfile
      create  app
      create  app/assets/config/manifest.js
      create  app/assets/javascripts/application.js
      create  app/assets/javascripts/cable.js
      create  app/assets/stylesheets/application.css
      create  app/channels/application_cable/channel.rb
      create  app/channels/application_cable/connection.rb
      create  app/controllers/application_controller.rb
      create  app/helpers/application_helper.rb
      create  app/jobs/application_job.rb
      create  app/mailers/application_mailer.rb
      create  app/models/application_record.rb
      create  app/views/layouts/application.html.erb
      create  app/views/layouts/mailer.html.erb
      create  app/views/layouts/mailer.text.erb
      create  app/assets/images/.keep
      create  app/assets/javascripts/channels
      create  app/assets/javascripts/channels/.keep
      create  app/controllers/concerns/.keep
      create  bin
      create  bin/bundle
      create  bin/rails
      create  bin/rake
      create  bin/setup
      create  bin/update
      create  config
      create  config/routes.rb
      create  config/application.rb
      create  config/environment.rb
      create  config/secrets.yml
      create  config/cable.yml
      create  config/puma.rb
      create  config/spring.rb
      create  config/environments
      create  config/environments/development.rb
      create  config/environments/production.rb
      create  config/environments/test.rb
      create  config/initializers
      create  config/initializers/application_controller_renderer.rb
      create  config/initializers/assets.rb
      create  config/initializers/backtrace_silencers.rb
      create  config/initializers/cookies_serializer.rb
      create  config/initializers/cors.rb
      create  config/initializers/filter_parameter_logging.rb
      create  config/initializers/inflections.rb
      create  config/initializers/mime_types.rb
      create  config/initializers/new_framework_defaults.rb
      create  config/initializers/session_store.rb
      create  config/initializers/wrap_parameters.rb
      create  config/locales
      create  config/locales/en.yml
      create  config/boot.rb
      create  config/database.yml
      create  db
      create  db/seeds.rb
      create  lib
      create  lib/tasks
      create  lib/tasks/.keep
      create  lib/assets
      create  lib/assets/.keep
      create  log
      create  log/.keep
      create  public
      create  public/404.html
      create  public/422.html
      create  public/500.html
      create  public/apple-touch-icon-precomposed.png
      create  public/apple-touch-icon.png
      create  public/favicon.ico
      create  public/robots.txt
      create  test/fixtures
      create  test/fixtures/.keep
      create  test/fixtures/files
      create  test/fixtures/files/.keep
      create  test/controllers
      create  test/controllers/.keep
      create  test/mailers
      create  test/mailers/.keep
      create  test/models
      create  test/models/.keep
      create  test/helpers
      create  test/helpers/.keep
      create  test/integration
      create  test/integration/.keep
      create  test/test_helper.rb
      create  tmp
      create  tmp/.keep
      create  tmp/cache
      create  tmp/cache/assets
      create  vendor/assets/javascripts
      create  vendor/assets/javascripts/.keep
      create  vendor/assets/stylesheets
      create  vendor/assets/stylesheets/.keep
      remove  config/initializers/cors.rb
         run  bundle install
Fetching gem metadata from https://rubygems.org/...........
Fetching version metadata from https://rubygems.org/...
Fetching dependency metadata from https://rubygems.org/..
Resolving dependencies.................................................
Using rake 11.2.2
Using concurrent-ruby 1.0.2
Using i18n 0.7.0
Using minitest 5.9.0
Using thread_safe 0.3.5
Using builder 3.2.2
Using erubis 2.7.0
Using mini_portile2 2.1.0
Using pkg-config 1.1.7
Using rack 2.0.1
Using nio4r 1.2.1
Using websocket-extensions 0.1.2
Using mime-types-data 3.2016.0521
Using arel 7.1.1
Using bundler 1.11.2
Using byebug 9.0.5
Using coffee-script-source 1.10.0
Using execjs 2.7.0
Using method_source 0.8.2
Using thor 0.19.1
Using debug_inspector 0.0.2
Using ffi 1.9.14
Using multi_json 1.12.1
Using rb-fsevent 0.9.7
Using puma 3.6.0
Using sass 3.4.22
Using tilt 2.0.5
Using spring 1.7.2
Using sqlite3 1.3.11
Using turbolinks-source 5.0.0
Using tzinfo 1.2.2
Using nokogiri 1.6.8
Using rack-test 0.6.3
Using sprockets 3.7.0
Using websocket-driver 0.6.4
Using mime-types 3.1
Using coffee-script 2.4.1
Using uglifier 3.0.1
Using rb-inotify 0.9.7
Installing turbolinks 5.0.1
Using activesupport 5.0.0
Using loofah 2.0.3
Using mail 2.6.4
Using listen 3.0.8
Using rails-dom-testing 2.0.1
Using globalid 0.3.7
Using activemodel 5.0.0
Installing jbuilder 2.6.0
Using rails-html-sanitizer 1.0.3
Installing spring-watcher-listen 2.0.0
Using activejob 5.0.0
Using activerecord 5.0.0
Using actionview 5.0.0
Using actionpack 5.0.0
Using actioncable 5.0.0
Using actionmailer 5.0.0
Using railties 5.0.0
Using sprockets-rails 3.1.1
Installing coffee-rails 4.2.1
Installing jquery-rails 4.1.1
Installing web-console 3.3.1
Using rails 5.0.0
Installing sass-rails 5.0.6
Bundle complete! 15 Gemfile dependencies, 63 gems now installed.
Use `bundle show [gemname]` to see where a bundled gem is installed.
         run  bundle exec spring binstub --all
* bin/rake: spring inserted
* bin/rails: spring inserted
</samp>
</pre>

The command `rails new` automatically runs `bundle install` after creating the following directories and files:

<pre>
.
└── hello_app
    ├── app
    │   ├── assets
    │   │   ├── config
    │   │   │   └── manifest.js
    │   │   ├── images
    │   │   ├── javascripts
    │   │   │   ├── application.js
    │   │   │   ├── cable.js
    │   │   │   └── channels
    │   │   └── stylesheets
    │   │       └── application.css
    │   ├── channels
    │   │   └── application_cable
    │   │       ├── channel.rb
    │   │       └── connection.rb
    │   ├── controllers
    │   │   ├── application_controller.rb
    │   │   └── concerns
    │   ├── helpers
    │   │   └── application_helper.rb
    │   ├── jobs
    │   │   └── application_job.rb
    │   ├── mailers
    │   │   └── application_mailer.rb
    │   ├── models
    │   │   ├── application_record.rb
    │   │   └── concerns
    │   └── views
    │       └── layouts
    │           ├── application.html.erb
    │           ├── mailer.html.erb
    │           └── mailer.text.erb
    ├── bin
    │   ├── bundle
    │   ├── rails
    │   ├── rake
    │   ├── setup
    │   ├── spring
    │   └── update
    ├── config
    │   ├── application.rb
    │   ├── boot.rb
    │   ├── cable.yml
    │   ├── database.yml
    │   ├── environment.rb
    │   ├── environments
    │   │   ├── development.rb
    │   │   ├── production.rb
    │   │   └── test.rb
    │   ├── initializers
    │   │   ├── application_controller_renderer.rb
    │   │   ├── assets.rb
    │   │   ├── backtrace_silencers.rb
    │   │   ├── cookies_serializer.rb
    │   │   ├── filter_parameter_logging.rb
    │   │   ├── inflections.rb
    │   │   ├── mime_types.rb
    │   │   ├── new_framework_defaults.rb
    │   │   ├── session_store.rb
    │   │   └── wrap_parameters.rb
    │   ├── locales
    │   │   └── en.yml
    │   ├── puma.rb
    │   ├── routes.rb
    │   ├── secrets.yml
    │   └── spring.rb
    ├── config.ru
    ├── db
    │   └── seeds.rb
    ├── Gemfile
    ├── Gemfile.lock
    ├── lib
    │   ├── assets
    │   └── tasks
    ├── log
    ├── public
    │   ├── 404.html
    │   ├── 422.html
    │   ├── 500.html
    │   ├── apple-touch-icon.png
    │   ├── apple-touch-icon-precomposed.png
    │   ├── favicon.ico
    │   └── robots.txt
    ├── Rakefile
    ├── README.md
    ├── test
    │   ├── controllers
    │   ├── fixtures
    │   │   └── files
    │   ├── helpers
    │   ├── integration
    │   ├── mailers
    │   ├── models
    │   └── test_helper.rb
    ├── tmp
    │   └── cache
    │       └── assets
    └── vendor
        └── assets
            ├── javascripts
            └── stylesheets

45 directories, 57 files
</pre>

`bundle install` reads the content of `ruby_helloworld/Gemfile` and install each dependency.

## Serve pages in development

Running `rails server` launches a server __for development purposes__ on `http://localhost:3000`

<pre class="shell">
<samp>
<span class="shell-prompt">rails_helloworld$</span> <kbd>rails server</kbd>
=> Booting Puma
=> Rails 5.0.0 application starting in development on http://localhost:3000
=> Run `rails server -h` for more startup options
Puma starting in single mode...
* Version 3.6.0 (ruby 2.3.1-p112), codename: Sleepy Sunday Serenity
* Min threads: 5, max threads: 5
* Environment: development
* Listening on tcp://localhost:3000
Use Ctrl-C to stop
</samp>
</pre>

Opening the address `http://localhost:3000` will show up `rails` homescreen:

![Homepage screenshot](/assets/rails_first_homescreen.png){:class="img-fluid"}

<pre>
<samp>
Started GET "/" for 127.0.0.1 at 2016-08-07 18:58:25 -0300
Processing by Rails::WelcomeController#index as HTML
  Parameters: {"internal"=>true}
  Rendering /var/lib/gems/2.3.0/gems/railties-5.0.0/lib/rails/templates/rails/welcome/index.html.erb
  Rendered /var/lib/gems/2.3.0/gems/railties-5.0.0/lib/rails/templates/rails/welcome/index.html.erb (8.7ms)
Completed 200 OK in 41ms (Views: 18.7ms | ActiveRecord: 0.0ms)
</samp>
</pre>


## Creating the Hello World page

### Routing

Edit the controller `app/controllers/routes.rb` that handles the homepage with the action `hello` to retrieve `Hello World`.

~~~ ruby
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
    render html: "hello, world!"
  end
end
~~~

### Adding controller action

Add the route that will handle the access to the `/` url with `root:controller#action`.

~~~ ruby
Rails.application.routes.draw do
  root 'application#hello'
end
~~~
