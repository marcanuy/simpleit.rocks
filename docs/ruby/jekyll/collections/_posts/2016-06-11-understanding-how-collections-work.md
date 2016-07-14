---
title: 
subtitle:
layout: post
tags:
- jekyll
- collections
description: >
  Jekyll Collections usage and examples.
---

## Overview

Jekyll _Collections_ makes it possible to define new [document] types.
A collection is an __array of documents__.

They are very similar to _posts_ but also have some unique features
that makes them more appropiate in certain circumstances.

Default ___Jekyll posts_ are _collections_ of type _posts___.

## Variables and front matter

Each __collection__ can have many __document__ files.

~~~
.
└──_my_collection
    ├── a_document.html
    └── another_document.md
~~~

### Variables of a Collection and Documents Collections

<div class="mermaid">
graph LR
    Collections["Collections"] == 1 === ColRelationship{" "}
    ColRelationship == N === Collection
    Collection["Collection<hr>label<br>docs<br>files<br>relative_directory<br>directory<br>output"] == 1 === relationship{" "}
    relationship == N === Document["Document<hr>path<br>relative_path<br>collection<br>date"]
</div>

## Creating a Collection

<div class="mermaid">
graph TB;
    A["Add *my_collection* as a collection directory in /_config.yml"]==>B("Add markdown files to *my_collection* directory");
	B==>C{"Is *output: true* in _config.yml"};
	C==>|yes|D["each file in the *my_collection* can be accesed through the url *my_collection/file* "];
	C==>|no|E["collections content is only available through the variable *site.my_collection* or *site.collections*"]
</div>

## Collections variables

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

### A single Collection Document variables

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

## Access

All Jekyll Collections can be accessed with the global variable _site_ using `site.collections`:

{% raw %}
~~~ liquid
{% for collection in site.collections%}
 Collection name: {{collection.label}} 
 Relative path to the collection's source directory: {{collection.relative_directory }}
 Full path to the collection's directory: {{collection.directory}}
 Output collection files as individual files?: {{collection.output}}
 {% for doc in collection.docs%}
  {{doc.title}}
  {{doc.slug}}
 {% endfor %}
{% endfor %}
~~~
{% endraw %}

And variables of each Document of a Collection can be accessed with:

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

[Document]: {% link docs/ruby/jekyll/_posts/2016-06-12-understanding-jekyll-posts.md %}
