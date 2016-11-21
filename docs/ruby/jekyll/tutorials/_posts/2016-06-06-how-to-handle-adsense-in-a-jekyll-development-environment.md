---
title: 
subtitle: Handle Adsense safely when developing.
layout: tutorial
tags:
- jekyll
- environments
- adsense
- development
description: >
  Adsense ads should be treated in a special way when developing a website to avoid being penalized and improve performance.
current: >
  sequenceDiagram
      local->>local: webpage development loading starts
      local->>AdsenseServer: javascript request
      AdsenseServer-->>local: adsense code
      local->>local: webpage ready
      local->>AdsenseServer: accidental clicks
goal: > # Goal graph
  sequenceDiagram
      local->>local: webpage development loading starts
      local->>local: webpage ready
flow: > # Process flow graph
  graph LR
    template["Avoid Adsense code in templates <br > in development environment"];
    template ==> build{"build the site with <br> JEKYLL_ENV"};
    build ==>|development| development["if JEKYLL_ENV is 'development' <br> it won't load ads"]
    build ==>|production| production["if JEKYLL_ENV is 'production' it will load and display ads"]
---

## Overview

Developing a site that uses Google Adsense has to be treated carefully. 
Developers often want to avoid their own clicks to not being penalized
by Google and minimize the speed of loading pages when debugging the
site locally.

It basically presents the following problems:

- __accidental clicks__. Avoid _repeatedly accidentally clicking_ on served ads while 
developing the site which can lead to an account ban.

>  Although publishers are not permitted to click on their own ads for any
> reason, we do understand that accidental clicks may occur. We therefore
> don't require that you contact us every time you click on your ads. Rest
> assured that your account is being properly credited for all clicks and
> impressions we consider to be valid.
{: cite="https://support.google.com/adsense/answer/1348754?hl=en#q1"}

- __speed__. Testing the site locally without waiting for each ad request 
to resolve, avoiding any javascript external request.

There are two main options to avoid them:

- telling Google that the _ad_ request is only for testing purposes
- avoid the javascript request at all

## Alternative 1: Google code parameter to make tests

There is a special parameter that can be enabled in Google Ad code to
avoid accidental clicks and set them up as tests. 

The downside of this approach is that it requires
[more checks](https://developers.google.com/custom-search-ads/docs/reference)
to modify an _ad_ code and if not enabled in production, **ads clicks won't
generate any revenue**.

> To use this code you must have an AdSense account
> with active permission to use AdSense Custom Search Ads.
{: cite="https://developers.google.com/custom-search-ads/docs/reference"}

The parameter is `'adtest' : 'on'` and it is defined:

> The adtest parameter is used to indicate that a request for ads is a test. 
> When the adtest parameter has a value of on, Google treats the request as
> a test and does not count the ad impressions or track the clickthrough results.
{: cite="https://developers.google.com/custom-search-ads/docs/reference#page-level-parameter-descriptions"}

An _easier_ and _safer_ alternative is to avoid the ad request at all.

## Alternative 2: Stop showing adsense ads

Jekyll templates can access the value of an environment variable passed
at build time to avoid any external javascript request. Based on this
variable the ads can be chosen to be shown or hidden depending on its value.

When building the site with `jekyll build` the variable
[JEKYLL_ENV](https://jekyllrb.com/docs/configuration/#specifying-a-jekyll-environment-at-build-time) 
defaults to *development*, setting it up as *production* makes it
possible to hide the ads in liquid templates

To build a production ready jekyll site it can be specified like this:

~~~ bash
$ JEKYLL_ENV=production jekyll build
~~~

When using a [Bundler command]
it should be used like:

~~~ bash
$ JEKYLL_ENV=production bundle exec jekyll build
~~~

## Environment in Jekyll liquid template

The environment can be accessed through the variable `jekyll.environment`.

The Adsense ad code provided by Google can be surrounded with the
environment detection so they only gets loaded in production like this:

{% raw %}
~~~ liquid
{% if jekyll.environment == "production" %}
  <script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
  <!-- simpleit_after_content -->
  <ins class="adsbygoogle"
       style="display:block"
       data-ad-client="ca-pub-****************"
       data-ad-slot="***********"
       data-ad-format="auto"></ins>
  <script>
    (adsbygoogle = window.adsbygoogle || []).push({});
  </script>
{% endif %}
~~~
{% endraw %}

A good practice is also to include something locally when not
showing them, to quickly identify ads placement, it can be:

- text with some color different from the rest of the site design
- a [placeholder](http://placehold.it/)
- an image like the ad from [example ads](https://support.google.com/adsense/answer/185666?hl=en)

