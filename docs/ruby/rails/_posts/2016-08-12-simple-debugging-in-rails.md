---
title: 
subtitle:
slug: 
layout: post
tags:
  - rails
  - debugging
description: > # Under 140 char. Used for meta description and main description
  Simple methods to debug when developing in rails.
---

## Overview

There are two very simple ways to debug a rails app:

- printing debug information directly in a view
- Using `byebug` gem

## Debug info in views

Adding the following line to `/app/views/layouts/application.html.erb` to 
show debugging information in each view __only in the _development_ environment__:

~~~ ruby
...
<body>
...
<%= debug(params) if Rails.env.development? %>
</body>
~~~

## Byebug gem

Rails 5 has the `byebug` gem included, adding `debugger` to any controller 
action, makes it possible to interact with the application in the console 
server each time a view is accessed in the browser. Adding `debugger` in
a controller action:

~~~ruby	
class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find(params[:id])
    debugger
  end
end
~~~

Then accessing a url of the application, the rails server shows 
the `(byebug) ` prompt so the developer can inspect current view
variables values, for example when accessing
`http://localhost:3000/users/1`:

<div class="shell">
<samp>
<span class="shell-prompt">(byebug)</span> <kbd>@user.password_digest</kbd><br>
"$2a$10$S3H9mBLQmfkBdaV3j/4M8ud7te9DwDwrreklqwjg4jt63oh528adv"
</samp>
</div>
