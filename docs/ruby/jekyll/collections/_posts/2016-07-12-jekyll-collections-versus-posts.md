---
title: 
subtitle:
layout: post
tags:
- jekyll
- collections
description: >
  Jekyll Collections and Posts comparison.
---

## Differences

These are the main differences between _Collections_ and _posts_.


### Categories

A _post_ in a subdirectory structure automatically gets subdirectories
names as its _categories_. 

A collection does not have _categories_ by default.

_Categories_ can be assigned to _collections_ with a parameter in each
file _front matter_.
{: class="aler alert-warning"}

### Filenames

_Post_ filenames must be in the format `YYYY-MM-DD-title.<markup>` which
assigns the post date, used to sort posts by creation date.

_Collection_ filenames doesn't need any special format in _filenames_,
they get the `date` from the file creation date.

In both cases, the document's _date_ can be overwritten in the front 
matter of each file setting the `date` variable. (i.e. `date: 2016-06-08`)
{: class="aler alert-warning"}

### Directories

Posts have the restriction of being only recognized if they are located
under a `_posts` folder. 
This restriction won't be removed as it is being kept to not break
previous versions.

_Collections_ can be located directly in any directory of the _collection_ folder.

### Dates

This is one of the most important difference between them.

_Posts_ were originally aimed for blogs, so the `date` is a central concept
that is also displayed in its filename, they are not likely to get updated
after published.

~~~
└── _posts
   ├── 2016-11-19-why-every-developer-should-use-emacs.md
   └── 2016-06-20-open-source-in-governments.md
~~~

- Beside _collections_ have a `date` property, this is not an important
concept as it is in _posts_, a clear structure is needed to locate each
file quickly when needed to update or add data to them.

~~~
└── _my_collection
   ├── open-source-in-governments.md
   └── why-every-developer-should-use-emacs.md
~~~

### Summary

Considering publishing a list of _books_ with both approaches:

- a list of standard _posts_ in `books` folder.
- a _collection_ in `_books` folder, with the following configuration:

  - In `/_config.yml`:

	~~~ liquid
	  collections:
	    books:
	      output: true
    ~~~

Note the underscore as the first character of the _collection_ folder <strong>`/_books`</strong>,
needed to let Jekyll handle the directory as a _collection_.
{: class="alert alert-warning"}

This is how they basically compare:

|-----------------+-------------------------------------------+--------------------------------------------|
|                 |             Collection                    |                   Post                     |
|-----------------|:-----------------------------------------:|:------------------------------------------:|
| Directories     | `/_books/science/`           | `/books/science/_posts/`                    |
| File            | `item.md`                                 | `2016-06-10-item.md`                       |
| {%raw%}{{ page.categories }}{%endraw%} |                     | `["books", "science"]`                         |
| {%raw%}{{ page.date }}{%endraw%}   | from file creation date:<br> `2016-07-11 23:03:59` | from filename: `2016-06-10`             |
| Document access | `site.books` <br> `site.collections`      | `site.categories.science`, <br> `site.collections`, <br> `site.categories.books` <br> or <br> `site.posts` |
|-----------------+-------------------------------------------+--------------------------------------------|
{: class="table"}

{% comment %} two columns table {% endcomment %}
|-----------------|:--------------------------------------------------------------------------------------:|
| File handling the URL <br> `http://example.com/books/science` | `/books.html` with `permalink: "/books/science"` <br> or <br> `/books/science/index.md` |
{: class="table"}

## Choosing between Collections and Posts


### Features of __Collections__:

- a __cleaner directory/subdirectories structure__ without `_posts` folder
in each nested level
- __cleaner filenames__ without mandatory dates.
- In a hierarchical subdirectoy structure, _categories_ can be simulated
processing the `path` property of each file.
- Collection filenames put more emphasis in its `title`, not the `date`.

### Features of __Posts__:

- _Posts_ were introduced in Jekyll before _collections_, so they are
__widely adopted__ and with __more plugins available__.
- Posts filenames put more emphasis in `dates`, not the `titles`.
- when using nested directories, creating each subdirectory _index_ is
straightforward.

## References

- Jekyll Collections docs <https://jekyllrb.com/docs/collections/>
- Jekyll Posts docs <https://jekyllrb.com/docs/posts/>


