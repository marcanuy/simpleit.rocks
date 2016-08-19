---
title: 
subtitle:
layout: post
tags:
  - rails
  - models
  - web-development
description: > # Under 140 char. Used for meta description and main description
  Make many-to-one idiomatically correct instances 
---

## Overview

Having a many-to-one model relationship in Rails, an instance of such model
can be manually made inserting the other model foreign id, but that is not
the most natural way to express it in _Rails_.

The most common way to write such relationship in _Rails_ is to __create the
related model through its association__.

## Example

Having the following models

<div class="mermaid">
graph LR;
    User--has_many-->Article;
</div>

then each `Article` would have an `user_id` _foreign key_.

## Manually assign FK

The _manually_ form for creating an `Article` instance with an associated
`User` would be to create an User and assign its `id` to the 
Article's `user_id` 

~~~ ruby
@user = User.create(name: "John")
@article = Article.new(content: "Foobar", user_id: @user.id)
~~~

## Create through association

Creating an article through the `user` instance would automagically set
`Article.user_id`.

~~~ ruby
@user = User.create(name: "John")
@article = @user.articles.build(content: "Foobar")
~~~


## Reference

- [Ruby on rails tutorial Book]({% link _books/ruby-on-rails-tutorial.md %})
- [Active Record Associations](http://guides.rubyonrails.org/association_basics.html)
