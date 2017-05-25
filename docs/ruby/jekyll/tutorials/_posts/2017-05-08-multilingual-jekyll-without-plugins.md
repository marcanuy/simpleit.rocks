---
description: Building a multilanguage Jekyll site with no plugins.

---

## Overview

This article shows a solution to have a multi language jekyll website
based mainly in having a file that groups all the available
translations for each page.

## Background

A common configuration for a multilanguage site is to use
subdirectories with Generic top-level domains (gTLDs).

This way the URLs of your site would look like: `example.com/<lang>/`,
e.g.:

- English `example.com/en/`
- Spanish `example.com/es/`
- German `example.com/de/`

This configuration has the benefit that it is easy to configure, can
use Search Console geotargeting and requires low maintenance as it is
in the same host.

To indicate to Search Engines that the German URL is the
German-language equivalent of the Spanish page, one of three ways can
be used:

1. HTML link element in header
2. HTTP header
3. Sitemap

In this guide I will be using the first one, adding a `link` element
in the `<head>` section of each HTML page. Each language page URL
should identify different language versions, **including itself**[^confirmationlink].

So the markup to tell Search Engine's algorithms to consider all of
these pages as alternate versions of each other is:

    <link rel="alternate" hreflang="es" href="http://example.com/es" />
    <link rel="alternate" hreflang="de" href="http://example.com/de" />
    <link rel="alternate" hreflang="en" href="http://example.com/en" />

To achieve this structure in Jekyll we will use:

- language subdirectories
- two data files
  - one to specify the navigation structure of the website
  - another one to map posts and pages equivalents based in their full path

## Steps

I will create a new Jekyll site to show the process:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>jekyll new --blank mysite</kbd>
<span class="shell-prompt">$</span> <kbd>cd mysite</kbd>
<span class="shell-prompt">$</span> <kbd>bundle init</kbd>
Writing new Gemfile to /mysite/Gemfile
<span class="shell-prompt">mysite$</span> <kbd>tree</kbd>
.
├── _drafts
├── Gemfile
├── index.html
├── _layouts
└── _posts

3 directories, 2 file
</samp>
</pre>

Edit `Gemfile` to have the Jekyll gem:

~~~
source "https://rubygems.org"

gem "jekyll"
~~~

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>bundle install</kbd>
...
Bundle complete! 1 Gemfile dependency, 19 gems now installed.
</samp>
</pre>


### Language directories

For each language we create a new directory that will contain its
posts, pages and, eventually, some categories as subdirectories.

In this example, one for English `/en`, one for Spanish `/es` and one
for German `/de`.

<pre class="shell">
<samp>
<span class="shell-prompt">mysite$</span> <kbd>mkdir -vp {en,es/_posts,de/_posts}</kbd>
mkdir: created directory 'en'
mkdir: created directory 'es'
mkdir: created directory 'es/_posts'
mkdir: created directory 'de'
mkdir: created directory 'de/_posts'
<span class="shell-prompt">mysite$</span> <kbd>mv _posts/ en/</kbd>
<span class="shell-prompt">mysite$</span> <kbd>tree</kbd>
├── de
│   └── _posts
├── _drafts
├── en
│   └── _posts
├── es
│   └── _posts
├── index.html
└── _layouts

8 directories, 1 file
</samp>
</pre>

This way our URLs will be generated containing the language at the
first level.

    http://example.com/es/...
	http://example.com/de/...
	http://example.com/en/...
	
Following this example we create example posts in each language.

In `en/_posts/2017-05-08-hello-world.md`:

~~~
---
title: Hello World
---

A "Hello, World!" program is a computer program that outputs or displays "Hello, World!" to a user. Being a very simple program in most programming languages...
~~~

In `es/_posts/2017-05-08-hola-mundo.md`:

~~~ liquid
---
title: Hola Mundo
---

En informática, un programa Hola mundo es el que imprime el texto
«¡Hola, mundo!» ...
~~~

In `de/_posts/2017-05-08-hallo-welt.md`

~~~ liquid
---
title: Hallo Welt
---

Ein Hallo-Welt-Programm ist ein kleines Computerprogramm, das auf
möglichst einfache Weise zeigen soll...
~~~

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>tree</kbd>
.
├── de
│   └── _posts
│       └── 2017-05-08-hallo-welt.md
├── _drafts
├── en
│   └── _posts
│       └── 2017-05-08-hello-world.md
├── es
│   └── _posts
│       └── 2017-05-08-hola-mundo.md
├── Gemfile
├── Gemfile.lock
├── index.html
└── _layouts

8 directories, 6 files
</samp>
</pre>


### Set post language

Now we automatically set the language of each post depending on the
above language folder
using
[Front Matter Defaults](https://jekyllrb.com/docs/configuration/#front-matter-defaults),
in `_config.yml`:

~~~ yaml
defaults:
  #languages
  -
    scope:
      path: ""
    values:
      lang: "en"
      layout: default
  -
    scope:
      path: "es"
    values:
      lang: "es"
  -
    scope:
      path: "de"
    values:
      lang: "de"
~~~

Every post and page located inside each folder, will automatically get
the right language.

So each webpage should have the language specified at the opening html
tag: `<html lang="en">`.

In the default layout in `_layouts/default.html` using English as the
fallback language:

{% raw %}
~~~ liquid
<!DOCTYPE html>
<html lang="{{ page.lang | default: site.lang | default: 'en' }}">
    <head>
    </head>
    <body>
	{{ content }}
    </body>
</html>
~~~
{% endraw %}

If you don't put the post/page in one of the language subdirectories,
then you will need to specify its language in the front matter, i.e.:

~~~
---
title: "Prueba"
lang: es
---
~~~

### Map set

Each time we add a post or page, the full path of each page should be
added to a special `_data/map.yml` where we specify which files are
equivalent in the other languages.

~~~
-
  en: en/_posts/2017-05-08-hello-world.md 
  es: es/_posts/2017-05-08-hola-mundo.md
  de: de/_posts/2017-05-08-hallo-welt.md
~~~

### Navigation menu

We create an include that iterates through pages and posts and select
only the group (located in `_data/map.yml`) which one of its items
equals the current page path. In `_includes/lang_nav.html`:

{% raw %}
~~~ liquid
<nav>
    {% for block in site.data.map %}
    {% for item in block[page.lang] %}
    {% if item == page.path %}
    {% for trans in block %}
    {% assign trans_path = trans[1] %}
    {% assign posts = site.posts | where:"path",trans_path %} 

    {% for item in posts %}
    {% if item.path == page.path %}
    <a hreflang="{{item.lang}}" class="active">{{site.data.locales[item.lang].title}}</a>
    {% else %}
    <a hreflang="{{item.lang}}" href="{{item.url|absolute_url}}">{{site.data.locales[item.lang].title}}</a>
    {% endif %}
    {% endfor %}

    {% assign pages = site.pages | where:"path",trans_path %}

    {% for item in pages %}
    {% if item.path == page.path %}
    <a hreflang="{{item.lang}}" class="active">{{site.data.locales[item.lang].title}}</a>
    {% else %}
    <a hreflang="{{item.lang}}" href="{{item.url|absolute_url}}">{{site.data.locales[item.lang].title}}</a>
    {% endif %}
    {% endfor %}
    
    {% endfor %}
    {% endif %}
    {% endfor %}
    {% endfor %}

</nav>
~~~
{% endraw %}

And use it in a layout:

{% raw %}
~~~ liquid
<body>
...
{% include lang_nav.html %}
</body>
~~~
{% endraw %}

### Alternate links

Finally to create the urls with the *alternate* link tags, in
`_includes/alternate.html`:

{% raw %}
~~~ liquid

{% for block in site.data.map %}
{% for item in block[page.lang] %}
{% if item == page.path %}
{% for trans in block %}
{% assign trans_path = trans[1] %}

{% assign posts = site.posts | where:"path",trans_path %} 
{% for item in posts %}
<link rel="alternate" hreflang="{{item.lang}}" href="{{item.url|absolute_url}}" />
{% endfor %}

{% assign pages = site.pages | where:"path",trans_path %} 
{% for item in pages %}
<link rel="alternate" hreflang="{{item.lang}}" href="{{item.url|absolute_url}}" />
{% endfor %}
{% endfor %}
{% endif %}
{% endfor %}
{% endfor %}
~~~
{% endraw %}

And use it in the head section of the layout:

{% raw %}
~~~ liquid
<head>
...
{% include alternate.html %}
</head>
~~~
{% endraw %}

## Repo

Putting it all together: <https://github.com/marcanuy/jekyll-multilanguage>.

## References

- [Multi-regional and multilingual sites](https://support.google.com/webmasters/answer/182192?hl=en#1)
- [Use hreflang for language and regional URLs](https://support.google.com/webmasters/answer/189077?hl=en&ref_topic=2370587)
- [Use a sitemap to indicate alternate language pages](https://support.google.com/webmasters/answer/2620865?hl=en&ref_topic=2370587)

[^confirmationlink]:
	> If page A links to page B, page B must link back to page A. If
	> this is not the case for all pages that use hreflang
	> annotations, those annotations may be ignored or not interpreted
	> correctly.
	> 
	> <footer class="blockquote-footer"> <cite>Missing confirmation links in <a href="https://support.google.com/webmasters/answer/189077?hl=en&ref_topic=2370587">Common Mistakes</a></cite></footer>
	{: class="blockquote" cite="https://support.google.com/webmasters/answer/189077?hl=en&ref_topic=2370587"}


