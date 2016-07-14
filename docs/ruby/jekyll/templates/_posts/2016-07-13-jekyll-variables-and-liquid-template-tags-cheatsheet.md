---
title: Jekyll Variables and Liquid template tags cheatsheet
subtitle:
layout: post
tags:
- jekyll
- templates
- liquid
description: >
  Jekyll template tags summary.
---

Summary of all the Jekyll variables and liquid tags available.

## General Liquid template tags

<dl>
<dt>jekyll.version</dt>
<dd>Jekyll version</dd>
<dt>jekyll.environment</dt>
<dd>Jekyll environment</dd>
</dl>

Example Output:

~~~
Version: {{jekyll.version}} #3.2.0.pre.beta1

Environment: {{jekyll.environment}} # development
~~~

[Source](https://github.com/jekyll/jekyll/blob/v3.2.0.pre.beta1/lib/jekyll/drops/jekyll_drop.rb)

## Global Variables 

<dl>
<dt>site.time</dt>
<dd>The current time (when you run the jekyll command).</dd>
<dt>site.pages</dt>
<dd>A list of all Pages.</dd>
<dt>site.posts</dt>
<dd>A reverse chronological list of all Posts.</dd>
<dt>site.related_posts</dt>
<dd>If the page being processed is a Post, this contains a list of up to ten related Posts. By default, these are the ten most recent posts. For high quality but slow to compute results, run the jekyll command with the --lsi (latent semantic indexing) option. Also note GitHub Pages does not support the lsi option when generating sites.</dd>
<dt>site.static_files</dt>
<dd>A list of all static files (i.e. files not processed by Jekyll's converters or the Liquid renderer). Each file has three properties: path, modified_time and extname.</dd>
<dt>site.html_pages</dt>
<dd>A subset of `site.pages` listing those which end in `.html`.</dd>
<dt>site.html_files</dt>
<dd>A subset of `site.static_files` listing those which end in `.html`.</dd>
<dt>site.collections</dt>
<dd>A list of all the collections.</dd>
<dt>site.data</dt>
<dd>A list containing the data loaded from the YAML files located in the _data directory.</dd>
<dt>site.documents</dt>
<dd>A list of all the documents in every collection.</dd>
<dt>site.categories.CATEGORY</dt>
<dd>The list of all Posts in category CATEGORY.</dd>
<dt>site.tags.TAG</dt>
<dd>The list of all Posts with tag TAG.</dd>
<dt>site.[CONFIGURATION_DATA]</dt>
<dd>All the variables set via the command line and your _config.yml are available through the site variable. For example, if you have url: http://mysite.com in your configuration file, then in your Posts and Pages it will be stored in site.url. Jekyll does not parse changes to _config.yml in watch mode, you must restart Jekyll to see changes to variables. </dd>
</dl>

[Source](https://jekyllrb.com/docs/variables/)

## Post

<dl>
<dt>page.title</dt>
<dd>The title of the Page.</dd>
<dt>page.date</dt>
<dd>The Date assigned to the Post. This can be overridden in a Post’s front matter by specifying a new date/time in the format YYYY-MM-DD HH:MM:SS (assuming UTC), or YYYY-MM-DD HH:MM:SS +/-TTTT (to specify a time zone using an offset from UTC. e.g. 2008-12-14 10:30:00 +0900).</dd>
<dt>page.categories</dt>
<dd>The list of categories to which this post belongs. Categories are derived from the directory structure above the _posts directory. For example, a post at /work/code/_posts/2008-12-24-closures.md would have this field set to ['work', 'code']. These can also be specified in the YAML Front Matter.</dd>
<dt>page.tags</dt>
<dd>The list of tags to which this post belongs. These can be specified in the YAML Front Matter.</dd>

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

[Source 1](https://jekyllrb.com/docs/frontmatter/)
[Source 2](https://jekyllrb.com/docs/variables/)

## Paginator

Paginator variables are available in index files only `index.{md,htm,html}`
{: class="alert alert-danger"}

<dl>
<dt>paginator.per_page</dt>
<dd>Number of Posts per page.</dd>
<dt>paginator.posts</dt>
<dd>Posts available for that page.</dd>
<dt>paginator.total_posts</dt>
<dd>Total number of Posts.</dd>
<dt>paginator.total_pages</dt>
<dd>Total number of pages.</dd>
<dt>paginator.page</dt>
<dd>The number of the current page.</dd>
<dt>paginator.previous_page</dt>
<dd>The number of the previous page.</dd>
<dt>paginator.previous_page_path</dt>
<dd>The path to the previous page.</dd>
<dt>paginator.next_page</dt>
<dd>The number of the next page.</dd>
<dt>paginator.next_page_path</dt>
<dd>The path to the next page.</dd>
</dl>

{{site.config.safe}}
{{site.config.exclude}}

## Collections

Variables that belong to _collections_ and also the ones defined in `_config.yml`

<dl>
<dt>label</dt>
<dd>The name of your collection, e.g. my_collection.</dd>
<dt>docs</dt>
<dd>An array of documents.</dd>
<dt>files</dt>
<dd>An array of static files in the collection.</dd>
<dt>relative_directory</dt>
<dd>The path to the collection's source directory, relative to the site source.</dd>
<dt>directory</dt>
<dd>The full path to the collections's source directory.</dd>
<dt>output</dt>
<dd>Whether the collection's documents will be output as individual files. </dd>
</dl>

### Collection Document

Variables in a single collection Document

<dl>
<dt>content</dt>
<dd>The (unrendered) content of the document. If no YAML Front Matter is provided, Jekyll will not generate the file in your collection. If YAML Front Matter is used, then this is all the contents of the file after the terminating `---` of the front matter.</dd>
<dt>output</dt>
<dd>The rendered output of the document, based on the content.</dd>
<dt>path</dt>
<dd>The full path to the document's source file.</dd>
<dt>relative_path</dt>
<dd>The path to the document's source file relative to the site source.</dd>
<dt>url</dt>
<dd>The URL of the rendered collection. The file is only written to the destination when the collection to which it belongs has output: true in the site's configuration.</dd>
<dt>collection</dt>
<dd>The name of the document's collection.</dd>
<dt>date</dt>
<dd> The date of the document's collection.</dd>
</dl>

[Source](https://jekyllrb.com/docs/collections/#documents)

## Common Code Snippets

### List of posts

{% raw %}
~~~ liquid
<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>
~~~
{% endraw %}

### List of collections

{% raw %}
~~~ liquid
{% for collection in site.collections %}

<h4>Collection {{forloop.index}}</h4>

<a href="{{site.baseurl}}/{{collection.label}}">{{collection.label | camelcase}}</a>
<dl>
<dt>Docs</dt>
<dd>{% comment %}{{ collection.docs }}{% endcomment %}</dd>
<dt>Files</dt>
<dd>{{ collection.files }}</dd>
<dt>Relative directory</dt>
<dd>{{ collection.relative_directory }}</dd>
<dt>Directory</dt>
<dd>{{ collection.directory}}</dd>
<dt>Output</dt>
<dd>{{ collection.output }}</dd>
</dl>
<hr>
{% endfor %}
~~~
{% endraw %}

#### Example Output

~~~
Collection 1

books

Docs
Files
Relative directory
    _books
Directory
    /home/marcanuy/Development/simpleit.rocks/_books
Output
    true

Collection 2

posts

Docs
Files
Relative directory
    _posts
Directory
    /home/marcanuy/Development/simpleit.rocks/_posts
Output
    true 
~~~

### List of document attributes of a Collection

{% raw %}
~~~ liquid
{% for collection in site.collections %}

<h4>Collection {{forloop.index}}</h4>

<dl>
{% for doc in collection.docs %}
<dt>Path</dt><dd>{{doc.path}}</dd>
<dt>Relative_path</dt><dd> {{doc.relative_path}}</dd>
<dt>Collection</dt><dd> {{doc.collection}}</dd>
<dt>Date</dt><dd> {{doc.date}}</dd>
{% endfor %}
</dl>
<hr>
{% endfor %}
~~~
{% endraw%}

#### Example Output

~~~
Path
    docs/ruby/jekyll/templates/_posts/2016-07-13-jekyll-variables-and-liquid-template-tags-cheatsheet.md
Relative_path
    docs/ruby/jekyll/templates/_posts/2016-07-13-jekyll-variables-and-liquid-template-tags-cheatsheet.md
Collection
    posts
Date
    2016-07-13 00:00:00 -0300
~~~
