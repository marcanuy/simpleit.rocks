---
title: 
subtitle:
slug: 
layout: post
tags:
description: > # Under 140 char. Used for meta description and main description
  A basic overview of Ruby on Rails main components and how they work together.
---

## Rails console

The console is based in `irb` (Interactive Ruby) and by default it starts with the _development environment_. The other environments defined by Rails are _test_ and _production_.

It is possible to test the app in the console without changing the database
running a [sandboxed](https://en.wikipedia.org/wiki/Sandbox_(software_development)) 
instance with `rails console--sandbox`:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>rails console --sandbox</kbd>
Running via Spring preloader in process 3485
Loading development environment in sandbox (Rails 5.0.0)
Any modifications you make will be rolled back on exit
irb(main):001:0> 
</samp>
</pre>

## Routes

Routes are defined in `/config/routes.rb`. 
After starting the server `rails serve` the current routes that rails 
recognizes can be listed at: <http://localhost:3000/rails/info/routes>

### Named routes

Defining a route in `/config/routes.rb` like: 

~~~ ruby
Rails.application.routes.draw do
  get 'contact', to: 'pages#contact'
end
~~~

makes several `named routes` variables available, like `contact_path`
and `contact_url` so they can be used in other files, e.g:

~~~ ruby
  #/test/controllers/pages_test.rb
  test "should get contact" do
    get contact_path
    assert_response :success
  end
end
~~~

In this case, these routes are `contact_path` and `contact_url`, 
the difference between them is that `_url` includes the full URL:

~~~
contact_path -> '/contact'
contact_url  -> 'http://www.example.com/contact'
~~~

The common convention is to use the `_path` form
__except when doing redirects__, where `_url` form is preferred because the
HTTP standard requires a _full_ URL after redirects.
{: class="alert alert-warning"}

A custom name for a route, instead of the default one,
can also be specified with the `as` keyword: 

~~~ ruby
  get 'contact', to: 'pages#contact'`, as: 'other-contact'
~~~

## Web Request Handling

Web requests are handled by 

- __Action Controller__ (<http://api.rubyonrails.org/classes/ActionController/Base.html>)
  - communicates with database
  - performs CRUD actions
- __Action View__ (<http://api.rubyonrails.org/classes/ActionView/Base.html>)
  - compiling the response to the request
	-  the final HTML output is composed by
	   - Templates
	   - Partials
	   - layouts

## Models

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>rails generate model User username:string email:string</kbd>
Running via Spring preloader in process 28981
      invoke  active_record
      create    db/migrate/20160810191131_create_users.rb
      create    app/models/user.rb
      invoke    test_unit
      create      test/models/user_test.rb
      create      test/fixtures/users.yml
</samp>
</pre>

## Controllers

## Views

### Templates

Templates can be `.erb`, `builder` or `JBuilder` templates

#### ERB

_ERB_ stands for `Embedded Ruby` files (ruby tags mixed with HTML).

_ERB_ templates are written in `.erb` files.

They are located in `app/views` directory.

Ruby code can be included using the tags:

- `<% %>` used for conditions, loops or blocks
- `<%= %>` outputs content

#### Partials

Partials templates are parts of a template that can be reused
and located in different files for better structuring the app.

To render a partial with `render` method:

- file: `_comment.html` gets rendered with: 

~~~ ruby
<%= render "comment" %>
~~~

- file: `app/views/shared/_comment.html.erb` with:

~~~ ruby
<%= render "shared/comment" %>
~~~
  
`<%= render partial: "product", locals: { product: @product } %>` can be 
called as: `<%= render "product", product: @product %>`

## Asset pipeline

The [assets pipeline](http://guides.rubyonrails.org/asset_pipeline.html) 
makes it easier to produce and manage static assets such as

- CSS
- JavaScript
- images

> The asset pipeline provides a framework to concatenate and minify or 
> compress JavaScript and CSS assets. It also adds the ability to write
> these assets in other languages and pre-processors such as CoffeeScript,
> Sass and ERB. It allows assets in your application to be automatically
> combined with assets from other gems.
> <footer class="blockquote-footer">Ruby on rails Guides</footer>
{: class="blockquote" cite="http://guides.rubyonrails.org/asset_pipeline.html"}

Pipeline assets can be located in:

- `app/assets` application assets, such as
  - custom images
  - JavaScript files
  - CSS
- `lib/assets` own libraries
  - code that doesn't fit into the scope of the application or
  - libraries which are shared across applications
- `vendor/assets` assets owned by outside entities, such as
  - JavaScript plugins
  - CSS frameworks

All of them have manifest files `app/assets/stylesheets/application.css` to
select how to process them and in what order.

Asset pipeline is handled in rails with Sprockets, the Rack-based asset packaging system <https://github.com/sstephenson/sprockets>.

## Testing

### Integration tests

Testing how several components of the app interacts with _integration tests_:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>rails generate integration_test SiteLayout</kbd>
Running via Spring preloader in process 9703
      invoke  test_unit
      create    test/integration/site_layout_test.rb
</samp>
</pre>



## Main resources

### Code

- <https://github.com/rails/rails/blob/5-0-stable>
- <http://api.rubyonrails.org/>

### Docs

- <http://guides.rubyonrails.org>
