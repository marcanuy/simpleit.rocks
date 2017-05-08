---
description: Guide to add Bootstrap 4 to Jekyll with focus on having also a CSS stylesheet using its variables and custom ones.
---

## Overview

The real power of Bootstrap is to use and redefine its variables in
our custom designs, that means, we should not simply add Bootstrap's
javascript and CSS stylesheets to use its components, we need to
change them and not making all the web look boringly the same.

This is a guide to make it easy to use Bootstrap 4 with a Jekyll
website and make it easy to customize it using its variables and
defining new ones.

## Background

Jekyll provides built-in support for *syntactically awesome
stylesheets* ([Sass]). 

Sass is a CSS extension language, it provides:

- Variables
- Nesting elements
  - Loops
  - Arguments
- Selector inheritance

It consists of two syntaxes:

- the original, indented, syntax uses the `.sass` extension.
- the newer syntax, more similar to CSS, uses `.scss` extension.

To make Jekyll process these SASS files, we need to create files with
the proper extension name (`.scss` or `.sass`) and start the file
contents with two lines of triple dashes.

A file named `assets/main.scss` will be rendered like `assets/main.css`.

As Bootstrap switched from `Less` to `Sass`[^bs-blog] now we can use
it directly without relying in parallel projects like [bootstrap-sass](https://github.com/twbs/bootstrap-sass)
used with Bootstrap 3.

## Installing Bootstrap 4

We will be using the package manager [Bower] to install Bootstrap. At
our Jekyll website root folder we use the <kbd>bower install</kbd>
command. In this case I will be using `bootstrap#v4.0.0-alpha.6` but
you can find the latest one
at
<https://v4-alpha.getbootstrap.com/getting-started/download/#bower>.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>bower install bootstrap#v4.0.0-alpha.6</kbd>
bower bootstrap#v4.0.0-alpha.6  cached https://github.com/twbs/bootstrap.git#4.0.0-alpha.6
bower bootstrap#v4.0.0-alpha.6         validate 4.0.0-alpha.6 against https://github.com/twbs/bootstrap.git#v4.0.0-alpha.6
bower jquery#>=1.9.1                     cached https://github.com/jquery/jquery-dist.git#3.1.1
bower jquery#>=1.9.1                   validate 3.1.1 against https://github.com/jquery/jquery-dist.git#>=1.9.1
bower tether#^1.4.0                      cached https://github.com/HubSpot/tether.git#1.4.0
bower tether#^1.4.0                    validate 1.4.0 against https://github.com/HubSpot/tether.git#^1.4.0
bower bootstrap#v4.0.0-alpha.6          install bootstrap#4.0.0-alpha.6
bower jquery#>=1.9.1                    install jquery#3.1.1
bower tether#^1.4.0                     install tether#1.4.0

bootstrap#4.0.0-alpha.6 bower_components/bootstrap
├── jquery#3.1.1
└── tether#1.4.0

jquery#3.1.1 bower_components/jquery

tether#1.4.0 bower_components/tether
</samp>
</pre>

## Adding new Sass load paths

We need to add this new path so Jekyll can process its Sass
files. 

Jekyll will look at the folder specified by the `sass_dir`
configuration key (`/_sass` by default), but it also supports extending
it, so it will process other folders too.

Instead of setting a custom sass folder with:

~~~ yaml
sass:
    sass_dir: _sass
~~~

we use the `load-paths`[^load-paths] key in `_config.yml` to add more paths:

~~~ yaml
sass:
    load_paths:
        - _sass
        - bower_components
~~~

`load_paths` only works when **not** in safe mode[^safe-mode]
{: .alert .alert-danger}

## Add javascript

Add Bootstrap core JavaScript, JQuery and Tether[^tether] (already installed when
installing Bootstrap) at the end of the document so the pages load
faster, just before the `</body>` HTML tag.

We add them in the default layout at `_layouts/default.html` or in
`footer.html` in the `_includes` folder:

~~~ liquid
<html>
<body>
...
<script src="{% raw %}{{'/bower_components/jquery/dist/jquery.min.js' | prepend: site.baseurl}}{% endraw %}"></script>
<script src="{% raw %}{{'/bower_components/tether/dist/js/tether.min.js' | prepend: site.baseurl}}{% endraw %}"></script>
<script src="{% raw %}{{'/bower_components/bootstrap/dist/js/bootstrap.min.js' | prepend: site.baseurl}}{% endraw %}"></script>
</body>
</html>
~~~

## Import Bootstrap and use Sass variables

### Create variables Sass partial

To be able to define new variables and reuse the ones defined in
Bootstrap, we create a new partial Sass file `_sass/_variables.scss`.

1. We define our variables
2. "Overwrite" the ones we want from Bootstrap
`bower_components/bootstrap/scss/_variables.scss` before loading them
and then 
3. we import the Bootstrap variables.

All the variables defined in Bootstrap 4 have the **`!default`**[^scss_default]
property at the end.
When Jekyll process each Scss file, **it only defines the variables that do not
have been assigned any value yet**, so we can define Bootstrap's
variables before Bootstrap itself define them. It is important to do
this **before importing the variables** because there are many of them
depending on each other to calculate CSS properties values.
{: .alert .alert-danger }

In `_sass/_variables.scss`:

~~~ scss
$custom-font-size: 20px;
@import "../bower_components/bootstrap/scss/variables";
~~~

### Import variables from main Sass file

After we have our variables, we import them from our main style sheet:

In `assets/main.scss` we import them and then work with our styles,
using the above variables:

~~~ scss
---
---

@import "variables";
@import "bootstrap/scss/bootstrap";

.content {
  font-size: $custom-font-size;
}
~~~

Don't miss the triple dashes at the beginning of the file to ensure
Jekyll reads the file to be transformed into CSS later
{: .alert .alert-danger}

## Add css to layout

After we have our `assets/main.scss`, Jekyll will process it and
generate the final CSS file: `assets/main.css`.

That is the path we need to add to our layout, in the `<head>`
section of `_layouts/default.html` we include the css: `<link
rel="stylesheet" href="/assets/main.css">`

~~~html
<html>
<head>
<!-- site css -->
<link rel="stylesheet" href="/assets/main.css">
</head>
</html>
~~~

## All together

This is the basic flow Jekyll follows processing these Scss files to
generate `assets/main.css`:

<div class="mermaid">
graph TB
        STYLESSCSS["Jekyll reads <strong>/assets/main.scss</strong>"]-->partials{"imports Sass partials"}
        partials--> |"import variables"|VARS
        partials--> |"import bootstrap/scss/bootstrap"|BS_SCSS
        VARS["/_sass/_variables.scss"]-->BS_VARIABLES
        BS_VARIABLES["@import '../bower_components/bootstrap/scss/variables';"]-->STYLESCSS
        BS_SCSS["/bower_components/bootstrap/scss/bootstrap.scss"]-->STYLESCSS
        STYLESCSS["Generates /assets/main.css"]
</div>

## Other

You’ll find
a
[minimal example of a site](https://github.com/marcanuy/jekyll-bootstrap4) in
Jekyll hosted on GitHub, based on this article and ready to use, and
the following step by step video:

<div class="embed-responsive embed-responsive-16by9">
  <iframe class="embed-responsive-item" src="//www.youtube.com/embed/0EI1V_Whgto" allowfullscreen></iframe>
</div>

It is also part of a Jekyll starter
site [jekyll-skeleton](https://github.com/marcanuy/jekyll-skeleton).

## Conclusion

When we build our site, Jekyll will process the `.scss` files with our
custom variables and we will have them in our `assets/main.css`. In
this example its content starts with the Bootstrap code and ends with
our custom `_main.scss` processed, looking like:

~~~ css
/*!
 * Bootstrap v4.0.0-alpha.6 (https://getbootstrap.com)
 * Copyright 2011-2017 The Bootstrap Authors
 * Copyright 2011-2017 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 */
/*! normalize.css v5.0.0 | MIT License | github.com/necolas/normalize.css */
html {
  font-family: sans-serif;
  line-height: 1.15;
  -ms-text-size-adjust: 100%;
  -webkit-text-size-adjust: 100%; }

...

.content {
  font-size: 20px; 
}

~~~

## References

- Sass (stylesheet language) <https://en.wikipedia.org/wiki/Sass_(stylesheet_language)>
- Sass project website <http://sass-lang.com/>
- Bootstrap 4 customization <http://v4-alpha.getbootstrap.com/getting-started/options/>

[Sass]: http://sass-lang.com/
[Bower]: https://bower.io
[^load-paths]: [Issue](https://github.com/jekyll/jekyll/issues/3366) referring the code at <https://github.com/jekyll/jekyll-sass-converter/blob/master/lib/jekyll/converters/scss.rb#L77>
[^tether]:
    [Tether](http://github.hubspot.com/tether/) is a small,
    focused JavaScript library for defining and managing the position of
    user interface (UI) elements in relation to one another on a web page
    used by Bootstrap
	
*[CSS]: Cascading Style Sheets

[^bs-blog]:
    <http://blog.getbootstrap.com/2015/08/19/bootstrap-4-alpha/>
	
	> Moved from Less to Sass. Bootstrap now compiles faster than ever
    > thanks to Libsass, and we join an increasingly large community of
    > Sass developers.

[^safe-mode]:
    Safe mode disables custom plugins, and ignores symbolic links. 
	
	> The reason multiple load paths are shut off in safe mode is
	> because of a fundamental inability to trust non-user content.
	> 
	> <footer class="blockquote-footer"> <cite>parkr comment in <a href="https://github.com/jekyll/jekyll-sass-converter/issues/44#issuecomment-169858494">Allow multiple load_paths in safe mode</a></cite></footer>
	{: class="blockquote" cite="https://github.com/jekyll/jekyll-sass-converter/issues/44#issuecomment-169858494"}
	

[^scss_default]:
	SASS Variable Defaults: !default <http://www.sass-lang.com/documentation/file.SASS_REFERENCE.html#variable_defaults_>

	> You can assign to variables if they aren’t already assigned by adding the !default flag to the end of the value. This means that if the variable has already been assigned to, it won’t be re-assigned, but if it doesn’t have a value yet, it will be given one.

	> For example:

    ~~~scss
	$content: "First content";
	$content: "Second content?" !default;
	$new_content: "First time reference" !default;

	#main {
	  content: $content;
	  new-content: $new_content;
	}
	~~~

	> is compiled to:

	~~~css
	#main {
	  content: "First content";
	  new-content: "First time reference"; }
	~~~
