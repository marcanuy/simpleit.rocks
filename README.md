
~~~
____  _                 _      ___ _____ ____            _        
/ ___|(_)_ __ ___  _ __ | | ___|_ _|_   _|  _ \ ___   ___| | _____ 
\___ \| | '_ ` _ \| '_ \| |/ _ \| |  | | | |_) / _ \ / __| |/ / __|
 ___) | | | | | | | |_) | |  __/| |  | |_|  _ < (_) | (__|   <\__ \
|____/|_|_| |_| |_| .__/|_|\___|___| |_(_)_| \_\___/ \___|_|\_\___/
                  |_|                                              
~~~

Software concepts, notes and tutorials.

[![Build Status](https://travis-ci.org/marcanuy/simpleit.rocks.svg?branch=master)](https://travis-ci.org/marcanuy/simpleit.rocks)

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-generate-toc again -->
**Table of Contents**

- [Writing](#writing)
    - [Adding Posts](#adding-posts)
    - [Adding a category](#adding-a-category)
    - [Adding a book](#adding-a-book)
- [Notes](#notes)
- [Deployment](#deployment)

<!-- markdown-toc end -->

This is the repository source code of <http://SimpleIt.rocks>.

Developed in [Jekyll](http://jekyllrb.com/) and hosted on
[Github Pages](https://pages.github.com/), the website static files
are located in
the
[gh-pages](https://github.com/marcanuy/simpleit.rocks/tree/gh-pages)
branch and the Jekyll files are
in [master](https://github.com/marcanuy/simpleit.rocks/tree/master)
branch.

# Writing

## Adding Posts

Post templates and snippets are located in [/_skel](https://github.com/marcanuy/simpleit.rocks/tree/master/_skel).

Add the new post in the proper category inside [/docs](https://github.com/marcanuy/simpleit.rocks/tree/master/docs).

Post content should contain headers from _h2_, since the main _h1_ is
automatically generated from the post main title.

## Adding a category

Create the category inside the `/docs` directory with the proper `index.md` file.

## Adding a book

Books are located in the [_books](https://github.com/marcanuy/simpleit.rocks/tree/master/_books) 
directory and are referenced in _posts_.

# Deployment

Deployment is done automatically
with [Travis CI](http://travis-ci.org/).

The
[deploy.sh](https://github.com/marcanuy/simpleit.rocks/blob/master/deploy.sh) script
is based
in
[Auto-deploying built products to gh-pages with Travis](https://gist.github.com/domenic/ec8b0fc8ab45f39403dd).

Each time the website is pushed to Github master branch, Travis
automatically checks for broken links executing `htlm-proofer` in the
generated static files with `scripts/cibuild.sh`, then if everything
is fine, the deployment is done to the `gh-pages` branch with
`deploy.sh`, so Github Pages publish the website.

To serve the website locally first
install [Bower](https://bower.io/#install-bower) and then `$ bundle
exec jekyll serve`.

<hr />

Coded by [marcanuy](http://marcanuy.com/).

