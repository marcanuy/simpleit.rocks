---
title: #If title is omitted, Jekyll generates a title based in the slug/filename
subtitle:
slug: 
layout: post
tags:
- git
- server
- bare-repository
description: > # Under 140 char. Used for meta description and main description

---

## Overview

The default configuration file is located in `/_config.yml`. Jekyll by _default_ comes with a lot of defaults that are not listed explicitly.

This article list the defaults values assumed by Jekyll.

The config file is in [YAML](http://yaml.org) format.

## Full list of all the default configuration options

{% raw %}
~~~ yaml
# Where things are
source:                      # Current-dir
destination:                 # Current-dir/_site
plugins_dir:    '_plugins'
layouts_dir:    '_layouts'
data_dir:       '_data'
includes_dir:   '_includes'
collections:    null
#  my_collection:
#    output: true
#    permalink: /awesome/:path/

# Handling Reading
safe:           false
include:        ['.htaccess']
exclude:        []
keep_files:     ['.git', '.svn']
encoding:       'utf-8'
markdown_ext:   'markdown,mkdown,mkdn,mkd,md'

# Filtering Content
show_drafts:    null
limit_posts:    0
future:         false
unpublished:    false

# Plugins
whitelist:      []
gems:           []

# Conversion
markdown:       'kramdown'
highlighter:    'rouge'
lsi:            false
excerpt_separator:  "\n\n"
incremental:    false

# Serving
detach:         false          # default to not detaching the serve
port:           '4000'
host:           '127.0.0.1'
baseurl:        ''
show_dir_listing:  false

# Output Configuration
permalink:      'date'
paginate_path:  '/page:num'
timezone:       null           # use local timezone

quiet:          false
verbose:        false
defaults:       
#  - scope:
#      path: ""
#      type: my_collection
#    values:
#      layout: page

rdiscount:
  extensions:   []


redcarpet:
  extensions:   []

kramdown:
  auto_ids:        true
  toc_levels:      '1..6'
  entity_output:   'as_char'
  smart_quotes:    'lsquo,rsquo,ldquo,rdquo'
  input:           "GFM"
  hard_wrap:       false
  footnote_nr:     1

~~~
{% endraw %}

Tested with Jekyll version v3.2.0 
{: class="alert alert-warning"}

[Config Source](https://github.com/jekyll/jekyll/blob/v3.2.0.pre.beta1/lib/jekyll/configuration.rb)
