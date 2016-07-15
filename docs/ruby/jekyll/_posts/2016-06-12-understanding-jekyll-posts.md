---
title: 
subtitle:
layout: post
tags:
- jekyll
- posts
description: >

---

## Overview

Posts can be nested in subdirectories but they always must be inside 
a `_posts` folder.

Their filename should follow the following format: `YYYY-MM-DD-article-name.MARKUP`. 

In this case `article-name` will be used as the post _slug_ and if there is no _title_ in the _front matter_ of the post, it will be converted to a title version removing the `-` chars.

## Post metadata

This is a common term used in [Book design](https://en.wikipedia.org/wiki/Book_design#Front_matter),
to refer to the first section of a book, usually its smallest section.

In a Jekyll context, each _post_ can have page-specific variables to be included at the beginning of the file using [YAML format](http://yaml.org/). This metadata is called in Jekyll __Front Matter__, and is the common place to define things like the post __title__, __layout__, __description__, or override site-wide variable values.

A common post looks like the following code, where the front matter goes inside `---` tag, and then the content of the _post_: 

{% raw %}
~~~ yaml
---
layout: post
title: My cool blog
---

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Ut enim ad minim veniam, quis nostrud exercitation ullamco 
laboris nisi ut aliquip ex ea commodo consequat.
~~~
{% endraw %}

### Variables

~~~
.
├── one_category
│   └── second_category
│      └── _posts
│	     └── nested_post.md
└── _posts
   ├── a_post.md
   └── another_post.md
~~~

### Variables of a Post and Documents Posts

<div class="mermaid">
graph LR
    Collections["Collections"] == 1 === ColRelationship{" "}
    ColRelationship == N === Collection
    Collection["Collection<hr>label<br>docs<br>files<br>relative_directory<br>directory<br>output"] == 1 === relationship{" "}
    relationship == N === Document["Document<hr>path<br>relative_path<br>collection<br>date"]
</div>

#### Front matter

Predefined Variables that can be used in the _front matter_ for a _post_:

<dl>
<dt>page.title</dt>
<dd>The title of the Page.</dd>
<dt>page.date</dt>
<dd>The Date assigned to the Post. This can be overridden in a Post’s front matter by specifying a new date/time in the format YYYY-MM-DD HH:MM:SS (assuming UTC), or YYYY-MM-DD HH:MM:SS +/-TTTT (to specify a time zone using an offset from UTC. e.g. 2008-12-14 10:30:00 +0900).</dd>
<dt>page.categories</dt>
<dd>The list of categories to which this post belongs. Categories are derived from the directory structure above the _posts directory. For example, a post at /work/code/_posts/2008-12-24-closures.md would have this field set to ['work', 'code']. These can also be specified in the YAML Front Matter.</dd>
<dt>page.tags</dt>
<dd>The list of tags to which this post belongs. These can be specified in the YAML Front Matter.</dd>
</dl>

#### In templates

Variables also available in templates

<dl>
<dt>page.content</dt>
<dd>The content of the Page, rendered or un-rendered depending upon what Liquid is being processed and what page is.</dd>
<dt>page.excerpt</dt>
<dd>The un-rendered excerpt of the Page.</dd>
<dt>page.url</dt>
<dd>The URL of the Post without the domain, but with a leading slash, e.g. /2008/12/14/my-post.html</dd>
<dt>page.id</dt>
<dd>An identifier unique to the Post (useful in RSS feeds). e.g. /2008/12/14/my-post</dd>
<dt>page.path</dt>
<dd>The path to the raw post or page. Example usage: Linking back to the page or post’s source on GitHub. This can be overridden in the YAML Front Matter.</dd>
<dt>page.next</dt>
<dd>The next post relative to the position of the current post in site.posts. Returns nil for the last entry.</dd>
<dt>page.previous</dt>
<dd>The previous post relative to the position of the current post in site.posts. Returns nil for the first entry. </dd>
</dl>
