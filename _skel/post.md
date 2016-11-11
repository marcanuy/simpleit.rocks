---
title: #If title is omitted, Jekyll generates a title based in the slug/filename
subtitle:
slug: 
layout: post
tags:
- git
- server
- bare-repository
description: > # Under 140 char. Used for meta description and main description

## Global Variables ##
layout: # If set, this specifies the layout file to use. Use the layout file name without the file extension. Layout files must be placed in the _layouts directory.
permalink: # If you need your processed blog post URLs to be something other than the site-wide style (default /year/month/day/title.html), then you can set this variable and it will be used as the final URL.
published: # Set to false if you don’t want a specific post to show up when the site is generated. 

## Predefined Variables for Posts ##
date: #A date here overrides the date from the name of the post. This can be used to ensure correct sorting of posts. A date is specified in the format YYYY-MM-DD HH:MM:SS +/-TTTT; hours, minutes, seconds, and timezone offset are optional.
category: #
categories: # Instead of placing posts inside of folders, you can specify one or more categories that the post belongs to. When the site is generated the post will act as though it had been set with these categories normally. Categories (plural key) can be specified as a YAML list or a comma-separated string.
tags: # Similar to categories, one or multiple tags can be added to a post. Also like categories, tags can be specified as a YAML list or a comma-separated string. 
weight: # order of a post relative to the same articles in a category
---

{% comment %} main content {% endcomment %}
## Overview

[Posts]({% link docs/ruby/jekyll/_posts/2016-06-12-understanding-jekyll-posts.md %})
