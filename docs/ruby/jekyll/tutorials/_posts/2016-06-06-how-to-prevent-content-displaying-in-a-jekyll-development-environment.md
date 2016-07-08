---
title: 
subtitle: Show content in production but avoid it in a local Jekyll instance
layout: tutorial
tags:
- jekyll
- environments
- adsense
- analytics
- disqus
description: > # Under 140 char. Used for meta description and main description
  How to prevent code execution when developing in Jekyll but displaying it in production. Avoid ads, analytics and disqus loading while developing.
current: > # Current status 
  sequenceDiagram
      local->>local: webpage loading starts
      local->>DisqusServer: javascript request
      DisqusServer-->>local: disqus code response
      local->>AnalyticsServer: javascript request
      local->>local: webpage ready
goal: > # Goal graph
  sequenceDiagram
      local->>local: webpage loading starts
      local->>local: webpage ready
flow: > # Process flow graph
  graph TB
    template["Configure different workflows <br > for each environment"];
    template ==> build{"build the site with <br> JEKYLL_ENV"};
    build ==>|development| development["if JEKYLL_ENV=development won't load code"]
    build ==>|production| production["JEKYLL_ENV=production will load code"]
---

## Overview

While developing and continuously testing a jekyll site, avoiding any 
javascript external request can greatly improve the loading speed of each 
page.

In the case of advertisements, also prevents from accidentally clicking
developer's own ads which can cause an account suspension.

The basic concept to make it possible is to __create different Jekyll builds
for _development_ and _production_ environments__.

## Environment

The easiest way to avoid any external javascript request is to detect the
environment on which Jekyll is running in liquid templates using the 
environment variable [JEKYLL_ENV] at build (or serve) time. 

To build a production ready jekyll site it can be specified like this:

~~~ bash
$ JEKYLL_ENV=production jekyll build
~~~

If none environment is explicitly set, then it uses by default
`JEKYLL_ENV=development`

When using a [Bundler command]
it should be used like:

~~~ bash
$ JEKYLL_ENV=production bundle exec jekyll build
~~~

## Detecting the environment in templates

To detect the environment in Jekyll liquid templates,
[jekyll.environment] variable contains the current environment.

For example, to avoid showing post tags in development:

{% raw %}
~~~ liquid
{% if jekyll.environment == "production" %}
 {{ post.tags }}
{% endif %}
~~~
{% endraw %}

[jekyll.environment]: http://www.rubydoc.info/gems/jekyll/3.1.6/Jekyll%2FDrops%2FJekyllDrop%3Aenvironment
[JEKYLL_ENV]: https://jekyllrb.com/docs/configuration/#specifying-a-jekyll-environment-at-build-time
[Bundler command]: http://bundler.io/man/bundle-exec.1.html
