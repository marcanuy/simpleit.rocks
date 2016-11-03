---
title: 
subtitle: Ensure all links and images exists
slug: 
layout: post
tags:
- html
- html5
- validator
- web-development
description: > # Under 140 char. Used for meta description and main description
  Check a statically generated website for broken links and images.
---

{% comment %} main content {% endcomment %}
## Overview

After generating a website statically, it is a good practice to check
that there are no broken links or images, there are some popular
command line tools for this, in this case I will be
using [htmlproofer](https://github.com/gjtorikian/html-proofer).

> HTMLProofer is a set of tests to validate your HTML output. These
> tests check if your image references are legitimate, if they have
> alt tags, if your internal links are working, and so on. It's
> intended to be an all-in-one checker for your output.
> <footer class="blockquote-footer"> <cite><a href="https://github.com/gjtorikian/html-proofer">HTMLProofer</a></cite></footer>
{: class="blockquote" cite="https://github.com/gjtorikian/html-proofer"}
	
## Install

It can be installed directly with *[gem](https://rubygems.org)*:

<pre class="shell">
<span class="shell-prompt">$</span> <kbd>gem install html-proofer</kbd>
</pre>

Or using *[bundle](http://bundler.io)*:

Adding `gem 'html-proofer'` to the file `Gemfile` and then:

<pre class="shell">
<span class="shell-prompt">$</span> <kbd>gem install html-proofer</kbd>
</pre>

## Executing

To test for broken links, just specify the directory, for example
using the common Jekyll output directory `_site`:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>htmlproofer ./_site</kbd>
0
</samp>
</pre>

## References

- <https://github.com/gjtorikian/html-proofer>
- <https://validator.w3.org/checklink>
- <https://jekyllrb.com/docs/continuous-integration/>

