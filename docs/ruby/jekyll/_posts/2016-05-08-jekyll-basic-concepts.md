---
title: Jekyll basic concepts
subtitle: Understanding Jekyll
description: Jekyll is the most popular static site generator, it has few basic concepts to understand how it works.
layout: post
---

## Definition

> Jekyll is, at its core, a text transformation engine. 
> The concept behind the system is this: you give it text written in your
> favorite markup language, be that Markdown, Textile, or just plain HTML, 
> and it churns that through a layout or a series of layout files. 
> Throughout that process you can tweak how you want the site URLs to look, 
> what data gets displayed in the layout, and more.
{: cite="https://jekyllrb.com/docs/structure/"}

### How Jekyll generates a site

<div class="mermaid">
graph TB
    defaultconf["Initialize a new Site with default configuration"]
    defaultconf==>read["Read Site data from disk and load it into internal data structures"]
    read==> customconf["Read custom _config.yml, overwrite default values"]
    customconf==>generate["Run each of the Generators"]
    generate==>render["Render the site to the destination folder"]
    render==>cleanup["Remove orphaned files and empty directories in destination"]
    cleanup==>write["Write static files, pages, and posts"]
</div>

Jekyll *Post* and *Pages* filenames works as urls slugs. 

## Articles

Content can be published in Jekyll in several ways:

- [Posts]({% link docs/ruby/jekyll/_posts/2016-06-12-understanding-jekyll-posts.md %})
- [Collections]({% link docs/ruby/jekyll/collections/_posts/2016-06-11-understanding-how-collections-work.md %})
- Pages
- Data

## Front Matter

Each _Post_ is composed by __metadata__ and __content__. This metadata is called the _Front Matter_, it assign custom variables to the current post.

The [Front Matter](https://jekyllrb.com/docs/frontmatter/) is the piece of code that tell Jekyll to process a page or post in a special way, where you can change the _layout_, _language_ or more configurations that if not specified they just took the default settings of _config.yml_.
. 

e.g.:

```
---
layout: post
title: My cool blog
---
```

It has two requirements:

+ It must be at the beginning of the file
+ It must be in [YAML](http://yaml.org/) format

### Predefined global variables

Predefined global that can be specified in the front matter of a post or page.

<dl>
<dt>layout</dt>
<dd>If set, this specifies the layout file to use. Use the layout file name without the file extension. Layout files must be placed in the _layouts directory.</dd>
<dt>permalink</dt>
<dd>If you need your processed blog post URLs to be something other than the site-wide style (default /year/month/day/title.html), then you can set this variable and it will be used as the final URL.</dd>
<dt>published</dt>
<dd>Set to false if you don’t want a specific post to show up when the site is generated. </dd>
</dl>

Source: <http://jekyllrb.com/docs/frontmatter/>

## Formatting syntax

The most common formatting syntax used in posts and pages are:

+ Markdown <https://daringfireball.net/projects/markdown/>
+ kramdown (a more powerful Markdown superset and currently used in _Github pages_)

## Syntax highlighting

By default Jekyll uses [Rouge](https://github.com/jneen/rouge) as its syntax highlter and is compatible with [Pygments](http://pygments.org/) highlighter. 

## Templating system ##

Jekyll uses the __Liquid__ template engine: <https://github.com/Shopify/liquid/wiki/Liquid-for-Designers>.

The template files processed by _Liquid_ uses three main concepts to generate the valid HTML files:

- __Tags__

  The programming logic in Luiqid themes
  
  <https://help.shopify.com/themes/liquid/tags> 
  
  e.g. `{ % if content == blank % }`
  
- __Objects__

  Attributes containers to display content
  
  <https://help.shopify.com/themes/liquid/objects>
  
  e.g. `{ { page.slug } }`
  
- __Filters__

  Modify the default output for each component
  
  <https://help.shopify.com/themes/liquid/filters>
  
  e.g. `{ { page.url | prepend: site.baseurl } }`

- Liquid reference: <https://help.shopify.com/themes/liquid>
- Liquid cheatsheet: <https://www.shopify.ca/partners/shopify-cheat-sheet>

### Liquid Related links

- <https://github.com/Shopify/liquid/wiki/liquid-for-designers>
- <https://www.shopify.ca/partners/shopify-cheat-sheet>
- <https://jekyllrb.com/docs/templates/>
- <https://help.shopify.com/themes/liquid/>
  - <https://www.shopify.ca/partners/shopify-cheat-sheet>

## Commands

* Local instance with bundle

~~~ bash
$ bundle exec jekyll serve --watch --drafts
~~~ 

References
==========

+ [Jekyll Official Documentation](https://jekyllrb.com/docs/home/)


