---
title: #If title is omitted, Jekyll generates a title based in the slug/filename
subtitle:
description: > # Under 140 char. Used for meta description and main description
  <description_content>
slug: 
layout: #<post|category_posts>
tags: # one or multiple tags can be added to a post. Also like categories, tags can be specified as a YAML list or a comma-separated string.
- foo #<first_tag>
- bar #<second_tag>
categories: # one or more categories that the post belongs to. YAML list or a comma-separated string.
permalink: # blog post final URLs other than the site-wide style (default /title)
published: #<true|false> default:true, false if you don’t want a specific post to show up when the site is generated
date: #A date here overrides the date from the name of the post. This can be used to ensure correct sorting of posts. Format YYYY-MM-DD HH:MM:SS +/-TTTT; hours, minutes, seconds, and timezone offset are optional.
weight: # order of a post relative to the other posts in a category
---

## Overview

## Summary

This is some text.[^1]. Other text.[^footnote].

## References

[^1]: Some *crazy* footnote definition.

[^footnote]:
	> Blockquotes can be in a footnote.

		as well as code blocks

	or, naturally, simple paragraphs.

Simple link: [Posts]({% link docs/ruby/jekyll/_posts/2016-06-12-understanding-jekyll-posts.md %})

Reference link: A link to the [kramdown hp].

[kramdown hp]: http://kramdown.gettalong.org "hp"

<hr>

Definition lists:

<dl class="row">
  <dt class="col-sm-3">Description lists</dt>
  <dd class="col-sm-9">A description list is perfect for defining terms.</dd>

  <dt class="col-sm-3 text-truncate">Truncated term is truncated</dt>
  <dd class="col-sm-9">Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</dd>

  <dt class="col-sm-3">Nesting</dt>
  <dd class="col-sm-9">
    <dl class="row">
      <dt class="col-sm-4">Nested definition list</dt>
      <dd class="col-sm-8">Aenean posuere, tortor sed cursus feugiat, nunc augue blandit nunc.</dd>
    </dl>
  </dd>
</dl>

<hr>

Abbreviations: 

This is an HTML example.

*[HTML]: Hyper Text Markup Language
