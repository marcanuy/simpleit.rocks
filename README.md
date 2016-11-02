
~~~
____  _                 _      ___ _____ ____            _        
/ ___|(_)_ __ ___  _ __ | | ___|_ _|_   _|  _ \ ___   ___| | _____ 
\___ \| | '_ ` _ \| '_ \| |/ _ \| |  | | | |_) / _ \ / __| |/ / __|
 ___) | | | | | | | |_) | |  __/| |  | |_|  _ < (_) | (__|   <\__ \
|____/|_|_| |_| |_| .__/|_|\___|___| |_(_)_| \_\___/ \___|_|\_\___/
                  |_|                                              
~~~

Software concepts, notes and tutorials.

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
[Github Pages](https://pages.github.com/), the relevant code is located in
the [gh-pages](https://github.com/marcanuy/simpleit.rocks/tree/gh-pages) branch.

# Writing

## Adding Posts

Post templates and snippets are located in [/_skel](https://github.com/marcanuy/simpleit.rocks/tree/master/_skel).

Add the new post in the proper category inside [/docs](https://github.com/marcanuy/simpleit.rocks/tree/master/docs).

## Adding a category

Create the category inside the `/docs` directory with the proper `index.md` file.

## Adding a book

Books are located in the [_books](https://github.com/marcanuy/simpleit.rocks/tree/master/_books) 
directory and are referenced in _posts_.

# Deployment

Deployment is done via
[deploy.sh](https://github.com/marcanuy/simpleit.rocks/blob/master/deploy.sh)
*shell* script.

<hr />

Coded by [marcanuy](http://marcanuy.com/).

