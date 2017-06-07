---
title: How to implement breadcrumbs on a Jekyll site with nested categories
subtitle: Hierarchical categories and breadcrumbs
layout: post
tags:
- git
- server
- bare-repository
description: >
  How to generate a list with links for each category when using hierarchical categories in Jekyll
---

## Overview

One of the ways to structure content in a Jekyll environment is to put
_posts_ in subdirectories, where each subdirectory becomes a _category_
of the _post_.

For example, the post `2016-06-08-my_title.md` in this directory structure
`/docs/science/_posts/2016-06-08-my_title.md` automatically gets the 
categories `docs` and `science`.

~~~
.
└── docs
    ├── index.md
    └── science
        ├── index.md
        └── _posts
            └── 2016-06-08-my_title.md
~~~

Then a _breadcrumb_ included in each post/category layout, can automatically
generate a link to each path of the structure


## Breadcrumb code

The *breadcrumbs* code should be placed at `/_includes/breadcrumbs.html`:

{% raw %}
~~~ liquid
	{% assign categories = include.path | split:"/" %}
	{% assign filename_without_extension = categories | last | split:"." | first %}
	{% if categories contains "_posts" or filename_without_extension == "index" %}
	{% comment %} posts are like /docs/python/_posts/2016-06-06-foobar.md {% endcomment %}
	{% comment %} OR pages are index.* i.e.: like /docs/python/index.md or index.html {% endcomment %}
	{% assign categories = categories | pop %}
	{% endif %}

	{% assign route="" %}

	<a href="/">Home</a>
	{% for category in categories %}
	<span class="prompt">>></span>
	{% assign route = route | append: '/' | append: category %}
	{% if forloop.last %}
	{% if include.title %}{{include.title}}{% else %}{{ category }}{% endif %}
	{% else %}
	<a href="{{ route }}">{{ category }}</a> 
	{% endif %}
	{% endfor %}
~~~
{% endraw %}

## Posts layouts

Each layout used in category pages and posts should _include_
the _breadcrumbs.html_ code, with the current `page path` and `title`
parameters.

In `/_layouts/post.html`:

{% raw %} 
~~~ liquid
..
{% include breadcrumbs.html path=page.path title=page.title %}
..
~~~
{% endraw %}

## Output 

The previous scheme would generate the following _breadcrumb_ for each case.

|-------------------------+----------------------------------+--------------------------------------------|
| URL                     | Generated Breadcrumb             | Served Filename                            |
|-------------------------|:---------------------------------|:-------------------------------------------|
| /                       | home                             | index.html                                 |
| /docs                   | home > docs                      | docs/index.md                              |
| /docs/science           | home > docs > science            | docs/science/index.md                      |
| /docs/about             | home > about                     | docs/about.md                              |
| /docs/science/my_title *| home > docs > science > my title | docs/science/_posts/2016-06-08-my_title.md |
|-------------------------+----------------------------------+--------------------------------------------|
{: class="table"}

(*) Using _titles_ without _dates_ in `_config.yml` with `permalink: /:title/`
{: class="alert alert-warning" role="alert"}

If page does not have a *title* variable in front matter, then its
filename will be displayed in breadcrumbs.
{: .alert .alert-info}
