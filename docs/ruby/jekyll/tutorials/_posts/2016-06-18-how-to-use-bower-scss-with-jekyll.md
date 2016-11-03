---
title:
subtitle: Include any scss from bower
layout: tutorial
tags:
- git
- server
- bare-repository
description: > # Under 140 char. Used for meta description and main description
  Automatically converting SCSS files into CSS in each Jekyll build.
current: > # Current status 
  graph TB
      A["$ bower update"]==>|Generates CSS|B
      B["$ scss foo_package/style.scss css/style.css"]
      B ==>|New package version| A
goal: > # Goal graph
  graph TB
      A["$ bower update"]==>|Generates CSS|B
      B["Jekyll automatically convert Bower SCSS file <br> into /css/CSS-FILE in each build"]
flow: > # Process flow graph
  graph TB
      A["Create symbolic link from Jekyll _sass directory to <br> Bower package directory"]
      B["Create a SCSS file in /css directory <br> to process Bower SCSS file "]
      A ==> B
      B["Include the generated CSS file from /css in a layout"]
---

## Overview

[Bower] makes it easier to keep up to date all the frameworks, libraries,
assets, and utilities used in web development.

Jekyll automatically generates __css__ files from __scss__.

This tutorial shows how to use both of them togheter, using Bootstrap-flex 4
as the example package.

## Setup

The default usage of [Bower] consists in having the packages downloaded to
`/bower_components` directory.

The problem is that Jekyll uses, by default, `/_sass` directory to put custom
`.scss` files, that are then processed into some file located at `/css` directory.

The goal is to be able to include the `bower_components` directories containing
`.scss` files, into `/_sass` directory to be consistent with default configurations.

Bower_components directory shouldn't be included into `/_sass` directory directly,
because they can contain a lot of different files, not only `.scss`, like `.js` 
or `css` files.
{: class="alert alert-danger"}

In this tutorial the Bootstrap 4 bower package is structured as:

~~~
bower_components/bootstrap/
├── dist
│   ├── css
│   │   ├── bootstrap.css
│   │   ├── bootstrap.min.css
│   └── js
├── ...
└── scss
    ├── _alert.scss
    ├── _animation.scss
    ├── bootstrap-flex.scss
    ├── bootstrap-grid.scss
    ├── bootstrap-reboot.scss
    ├── bootstrap.scss
    ├── _breadcrumb.scss
    ├── ...
    └── _variables.scss

~~~

We want to be able to include `/bower_components/bootstrap/scss/bootstrap-flex.scss`
in our Jekyll website, as it is not currently distributed by default as a `css` file
in `/bower_components/bootstrap/dist` folder.

## Generating CSS files from Bower directories

A symbolic link should be created inside `/_sass` pointing to the bower
directory containing the `.scss` files.

In the base of the jekyll project:

~~~ bash
$ ln -s bower_components/bootstrap/ _sass/bootstrap
~~~

This creates a symbolic link named `bootstrap` inside the `/_sass`
directory to `bower_components/bootstrap/`.

To generate the automatically, Jekyll needs to have the following SCSS file
in `/css/bootstrap-flex.scss`, so it can generate `/css/bootstrap-flex.css`.

{%raw%}
~~~
---
---
@charset "utf-8";

// Import partials from `sass_dir` (defaults to `_sass`)
@import
        "bootstrap/scss/bootstrap-flex"
;
~~~
{%endraw%}

Each time Jekyll builds a site it will create `/css/bootstrap-flex.css`.

## Including CSS into templates

To make the website use the newly generated CSS file, it should be included
in a template like:

~~~ css
<link rel="stylesheet" type="text/css" href="{{ site.baseurl }}/css/bootstrap-flex.css">
~~~

## Review

This is a simple process respecting each package default directories, that makes it 
easy to maintain Bower packages up to date, without having to regenerate
them manually with the `scss` command.

## References

- Assets Jekyll docs <https://jekyllrb.com/docs/assets/>
- Bower docs <https://bower.io/>

[Bower]: https://bower.io/
