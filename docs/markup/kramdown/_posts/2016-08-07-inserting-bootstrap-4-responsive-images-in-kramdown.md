---
title: 
subtitle:
slug: 
layout: post
tags:
- kramdown
- bootstrap-4
description: > # Under 140 char. Used for meta description and main description
  How to insert images with the Bootstrap 4 responsive class in kramdown.
---

The common markup for inserting images in kramdown is:

~~~ markdown
![Homepage screenshot](/assets/homescreen.png)
~~~

The most used way to add a class to any markup is to use _inline annotations_ __in the line below__ of the markup with `{:class="a-class"}` but in this case it should be used in the same line, so this: 

~~~ markdown
![Homepage screenshot](/assets/homescreen.png){:class="img-fluid"}
~~~

generates:

~~~ html
<img src="/assets/rails_first_homescreen.png" alt="Homepage screenshot" class="img-fluid">
~~~
