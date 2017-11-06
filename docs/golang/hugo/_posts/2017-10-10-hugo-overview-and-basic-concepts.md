---
title: Hugo overview and basic concepts
description: A first approach to Hugo web static generator
---

## Overview

Hugo is a static site generators based in Google's
[Go](https://golang.org) language.

This is a guide based in the official *quickstart* guide explaining
its concepts.

## Command line

As with all modern frameworks, it comes with a command line utility
<kbd>hugo</kbd>.


> Hugo’s CLI scaffolds a project directory structure and then takes
> that single directory and uses it as the input to create a complete
> website.
> 
> <footer class="blockquote-footer"> <cite><a href="https://gohugo.io/getting-started/directory-structure/">Hugo Directory Structure</a></cite></footer>
{: class="blockquote" cite="https://gohugo.io/getting-started/directory-structure/"}


<pre class="shell">
<samp>
<span class="shell-prompt">quickstart$</span> <kbd>hugo --help</kbd>
hugo is the main command, used to build your Hugo site.

Hugo is a Fast and Flexible Static Site Generator
built with love by spf13 and friends in Go.

Complete documentation is available at http://gohugo.io/.

Usage:
  hugo [flags]
  hugo [command]

Available Commands:
  server      A high performance webserver
  version     Print the version number of Hugo
  env         Print Hugo version and environment info
  config      Print the site configuration
  benchmark   Benchmark Hugo by building a site a number of times.
  convert     Convert your content to different formats
  new         Create new content for your site
  list        Listing out various types of content
  undraft     Undraft changes the content's draft status from 'True' to 'False'
  import      Import your site from others.
  gen         A collection of several useful generators.

Flags:
  -b, --baseURL string          hostname (and path) to the root, e.g. http://spf13.com/
  -D, --buildDrafts             include content marked as draft
  -E, --buildExpired            include expired content
  -F, --buildFuture             include content with publishdate in the future
      --cacheDir string         filesystem path to cache directory. Defaults: $TMPDIR/hugo_cache/
      --canonifyURLs            if true, all relative URLs will be canonicalized using baseURL
      --cleanDestinationDir     Remove files from destination not found in static directories
      --config string           config file (default is path/config.yaml|json|toml)
  -c, --contentDir string       filesystem path to content directory
  -d, --destination string      filesystem path to write files to
      --disable404              Do not render 404 page
      --disableRSS              Do not build RSS files
      --disableSitemap          Do not build Sitemap file
      --enableGitInfo           Add Git revision, date and author info to the pages
      --forceSyncStatic         Copy all files when static is changed.
      --i18n-warnings           Print missing translations
      --ignoreCache             Ignores the cache directory
  -l, --layoutDir string        filesystem path to layout directory
      --log                     Enable Logging
      --logFile string          Log File path (if set, logging enabled automatically)
      --noChmod                 Don't sync permission mode of files
      --noTimes                 Don't sync modification time of files
      --pluralizeListTitles     Pluralize titles in lists using inflect (default true)
      --preserveTaxonomyNames   Preserve taxonomy names as written ("Gérard Depardieu" vs "gerard-depardieu")
      --quiet                   build in quiet mode
      --renderToMemory          render to memory (only useful for benchmark testing)
  -s, --source string           filesystem path to read files relative from
      --stepAnalysis            display memory and timing of different steps of the program
  -t, --theme string            theme to use (located in /themes/THEMENAME/)
      --uglyURLs                if true, use /filename.html instead of /filename/
  -v, --verbose                 verbose output
      --verboseLog              verbose logging
  -w, --watch                   watch filesystem for changes and recreate as needed

Additional help topics:
  hugo check     Contains some verification checks

Use "hugo [command] --help" for more information about a command.
</samp>
</pre>

## Create a site

To create a new site <kbd>hugo new site</kbd>.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>hugo new site --help</kbd>
Create a new site in the provided directory.
The new site will have the correct structure, but no content or theme yet.
Use `hugo new [contentPath]` to create new content.

Usage:
  hugo new site [path] [flags]

Flags:
	  --force           Init inside non-empty directory
  -f, --format string   config & frontmatter format (default "toml")

Global Flags:
	  --config string    config file (default is path/config.yaml|json|toml)
	  --log              Enable Logging
	  --logFile string   Log File path (if set, logging enabled automatically)
	  --quiet            build in quiet mode
  -s, --source string    filesystem path to read files relative from
  -v, --verbose          verbose output
      --verboseLog       verbose logging
</samp>
</pre>

Then we will create a *quickstart* project:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>hugo new site quickstart</kbd>
Congratulations! Your new Hugo site is created in /tmp/quickstart.

Just a few more steps and you're ready to go:

1. Download a theme into the same-named folder.
   Choose a theme from https://themes.gohugo.io/, or
   create your own with the "hugo new theme < THEMENAME >" command.
2. Perhaps you want to add some content. You can add single files
   with "hugo new < SECTIONNAME >/< FILENAME >.< FORMAT >".
3. Start the built-in live server via "hugo server".

Visit https://gohugo.io/ for quickstart guide and full documentation.
</samp>
</pre>

That will create the basic Hugo site structure:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>tree quickstart/</kbd>
quickstart/
├── archetypes
├── config.toml
├── content
├── data
├── layouts
├── static
└── themes
 
6 directories, 1 file
</samp>
</pre>

### Structure

Structure explanation:

- **archetypes**:
  [archetypes](https://gohugo.io/content-management/archetypes/) are
  pre-configured front matter post data to add when using <kbd>hugo
  new</kbd>
- **config.toml**: hugo
  [configuration](https://gohugo.io/getting-started/configuration/#all-variables-yaml).
  
  - Hugo will look for `./config.toml`, `./config.yaml` and
    `./config.json`, in that order.
  - Defines:
	- how to render the website
	- menus
	- site-wide parameters
	- values under `params` key can be used with
      [`.Site.Params`](https://gohugo.io/variables/site/) variable in
      templates.
	- all Hugo's config values can be seen with the command `hugo
      config`.
	- all keys can be set with environmental variables in uppercase
      and `HUGO_` prefix, for example, to set the site title and build
      the site:
	  
	      $ env HUGO_TITLE="New Title" hugo

- **content**:
  [content](https://gohugo.io/content-management/organization/) that can
  include `/posts`, `/blog` and `/articles`, sections with
  [content-types](https://gohugo.io/content-management/types/)
- **data**: data holds configuration files, and [data
  templates](https://gohugo.io/templates/data-templates/) pulling data
  from dynamic content.
- **templates**: [templates](https://gohugo.io/templates/) specify how content is rendered.
- **static**: assets directory.

## Themes

Hugo [themes](https://gohugo.io/themes/) are powered by Go's template
libraries ([text](https://golang.org/pkg/text/template/) and
[html](https://golang.org/pkg/html/template/) libraries).

Themes are designed to:

- reduce code duplication
- easy to both customize and
- keep in synch with the upstream theme.

A repository of themes are available at <https://themes.gohugo.io>,
from there we have to select one, and locate it in `/themes`
directory.

### Add

Themes can be added as git submodules, so it is possible to use
another project from within the main site, or cloned directly into the
`themes` directory.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>cd quickstart</kbd>
<span class="shell-prompt">$</span> <kbd>git init</kbd>
<span class="shell-prompt">quickstart$</span> <kbd>git submodule add https://github.com/budparr/gohugo-theme-ananke.git themes/ananke;</kbd>
Cloning into '/tmp/quickstart/themes/ananke'...
remote: Counting objects: 850, done.
remote: Compressing objects: 100% (18/18), done.
remote: Total 850 (delta 10), reused 21 (delta 9), pack-reused 823
Ricezione degli oggetti: 100% (850/850), 2.38 MiB | 385.00 KiB/s, done.
Risoluzione dei delta: 100% (431/431), done.
</samp>
</pre>

### Choose

Now we must specify Hugo to use this theme.

This can be done adding it to the configuration file or specifying
theme name at run time.

### Customize

Themes that follows Hugo's convention for folder structure and naming,
can be customized without changing original code, just using your
project's working directory, overriding specific sections and staying
current with a theme's upstream.

Every time Hugo looks for a theme file, it will look first in **your**
project, and if it doesn't find anything, it will look at `/themes/<
THEME NAME >` directory. 

For example, to customize the file 

    /themes/< THEME >/layouts/_default/single.html`
	
you simply copy the above file to you local instance and edit as you
wish:

    /layouts/_default/single.html

### How themes work

Generally, website pages consist of page showing a single item or a
list of items, in Hugo these cases are covered by the `_default` theme:

- a single piece of content: `layouts/_default/single.html`
- a list of content items: `layouts/_default/list.html`.

After looking for the default layout, Hugo also seeks for content
types or have layouts that apply to specific sections like a blog or
another type.

Static content present in the `static` directory, will be copied to
the final site.

#### In Config

To add the theme to the configuration file: `config.toml` we set the
`theme` property.

~~~ toml
languageCode = "en-us"
title = "My New Hugo Site"
baseurl = "http://example.org/"
theme = "ananke"
~~~

#### at Run time

To use a theme specifying the name at command line, `hugo` comes with
the `-t` flag, then it can be used as <kbd>hugo -t ananke</kbd>

## Create content

Hugo by default uses a markdown processor for Go called
[blackfriday](https://github.com/russross/blackfriday).

A typical post contains a special section containing metadata and then the
content. The metadata is called frontmatter and is the first part of
the file between `+++` lines, for example a post looks like:

~~~ blackfriday
---
date: 2017-04-09T10:58:08-04:00
description: "The Grand Hall"
featured_image: "/images/Pope-Edouard-de-Beaumont-1844.jpg"
tags: ["scene"]
title: "Chapter I: The Grand Hall"
---

Three hundred and forty-eight years, six months, and nineteen days ago
to-day, the Parisians awoke to the sound of all the bells in the triple
circuit of the city, the university, and the town ringing a full peal.
~~~

To add new content we use `hugo new`.

<pre class="shell">
<samp>
<span class="shell-prompt">quickstart$</span> <kbd>hugo new --help</kbd>
Create a new content file and automatically set the date and title.
It will guess which kind of file to create based on the path provided.

You can also specify the kind with `-k KIND`.

If archetypes are provided in your theme or site, they will be used.

Usage:
  hugo new [path] [flags]
  hugo new [command]

Available Commands:
  site        Create a new site (skeleton)
  theme       Create a new theme

Flags:
      --editor string   edit new content with this editor, if provided
  -f, --format string   frontmatter format (default "toml")
  -k, --kind string     Content type to create
  -s, --source string   filesystem path to read files relative from

Global Flags:
      --config string    config file (default is path/config.yaml|json|toml)
      --log              Enable Logging
      --logFile string   Log File path (if set, logging enabled automatically)
      --quiet            build in quiet mode
  -v, --verbose          verbose output
      --verboseLog       verbose logging

Use "hugo new [command] --help" for more information about a command.
</samp>
</pre>

Hugo has its posts and content in `contents/posts` directory, we add a
post called `my-first-post.md` with the basic post structure specified
in the front-matter with `hugo new < post >`.

<pre class="shell">
<samp>
<span class="shell-prompt">quickstart$</span> <kbd>hugo new posts/my-first-post.md</kbd>
/tmp/quickstart/content/posts/my-first-post.md created
</samp>
</pre>

It creates a basic post skeleton, the front-matter needed to build a
post:

~~~
+++
title = "This is my first post"
date = "2017-10-10"
tags = []
featured_image = ""
description = "A new post added"
+++

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis id tellus dolor. 

Cras vitae consequat risus. Suspendisse quis justo arcu.
~~~

## Serve site

To serve the site, especially useful when developing locally:
<kbd>hugo serve</kbd>.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>hugo serve --help</kbd>
Hugo provides its own webserver which builds and serves the site.
While hugo server is high performance, it is a webserver with limited options.
Many run it in production, but the standard behavior is for people to use it
in development and use a more full featured server such as Nginx or Caddy.

'hugo server' will avoid writing the rendered and served content to disk,
preferring to store it in memory.

By default hugo will also watch your files for any changes you make and
automatically rebuild the site. It will then live reload any open browser pages
and push the latest content to them. As most Hugo sites are built in a fraction
of a second, you will be able to save and see your changes nearly instantly.

Usage:
  hugo server [flags]

Aliases:
  server, serve


Flags:
	  --appendPort              append port to baseURL (default true)
  -b, --baseURL string          hostname (and path) to the root, e.g. http://spf13.com/
	  --bind string             interface to which the server will bind (default "127.0.0.1")
  -D, --buildDrafts             include content marked as draft
  -E, --buildExpired            include expired content
  -F, --buildFuture             include content with publishdate in the future
	  --cacheDir string         filesystem path to cache directory. Defaults: $TMPDIR/hugo_cache/
	  --canonifyURLs            if true, all relative URLs will be canonicalized using baseURL
	  --cleanDestinationDir     Remove files from destination not found in static directories
  -c, --contentDir string       filesystem path to content directory
  -d, --destination string      filesystem path to write files to
	  --disable404              Do not render 404 page
	  --disableLiveReload       watch without enabling live browser reload on rebuild
	  --disableRSS              Do not build RSS files
	  --disableSitemap          Do not build Sitemap file
	  --enableGitInfo           Add Git revision, date and author info to the pages
	  --forceSyncStatic         Copy all files when static is changed.
	  --i18n-warnings           Print missing translations
	  --ignoreCache             Ignores the cache directory
  -l, --layoutDir string        filesystem path to layout directory
	  --meminterval string      interval to poll memory usage (requires --memstats), valid time units are "ns", "us" (or "µs"), "ms",
"s", "m", "h". (default "100ms")
	  --memstats string         log memory usage to this file
	  --noChmod                 Don't sync permission mode of files
	  --noTimes                 Don't sync modification time of files
	  --pluralizeListTitles     Pluralize titles in lists using inflect (default true)
  -p, --port int                port on which the server will listen (default 1313)
	  --preserveTaxonomyNames   Preserve taxonomy names as written ("Gérard Depardieu" vs "gerard-depardieu")
	  --renderToDisk            render to Destination path (default is render to memory & serve from there)
  -s, --source string           filesystem path to read files relative from
	  --stepAnalysis            display memory and timing of different steps of the program
  -t, --theme string            theme to use (located in /themes/THEMENAME/)
	  --uglyURLs                if true, use /filename.html instead of /filename/
  -w, --watch                   watch filesystem for changes and recreate as needed (default true)

Global Flags:
	  --config string    config file (default is path/config.yaml|json|toml)
	  --log              Enable Logging
	  --logFile string   Log File path (if set, logging enabled automatically)
	  --quiet            build in quiet mode
  -v, --verbose          verbose output
	  --verboseLog       verbose logging
</samp>
</pre>

## Generate files

To build the site, just <kbd>hugo</kbd>. 

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>hugo</kbd>
Started building sites ...

Built site for language en:
0 draft content
0 future content
0 expired content
1 regular pages created
8 other pages created
0 non-page files copied
1 paginator pages created
0 tags created
0 categories created
total in 50 ms
</samp>
</pre>
