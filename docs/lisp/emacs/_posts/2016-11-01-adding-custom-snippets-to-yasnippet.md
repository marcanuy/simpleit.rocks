---
description: 
layout: post
---

## Overview

When using [Yasnippets](https://github.com/joaotavora/yasnippet) (a
popular template system for Emacs), you will usually need to add your
custom snippets to easy the task of writing repetitive content. 

To extend the snippets, there is a special snippet template that acts
as a template in a similar way that *yasnippets* handle other templates.

## Writing a snippet

### Snippet directory

The directory for storing snippets is defined by the variable
`yas-snippet-dirs` and by default is `~/.emacs.d/snippets`.

You can check its value in your system with `C-v yas-snippet-dirs`.
{: class="alert alert-info"}

### Creating the snippet

To create the snippet file execute the command `yas-new-snippet` *(C-c
& C-n)*,
yasnippets internally expands the `snippet-writing` snippet.

A new buffer will open with the base model to define the new snippet
in the **snippet-mode** major mode.

~~~ 
# -*- mode: snippet -*-
# name: 
# key: 
# --

~~~

#### Example

The following is an example of the current `for` statement in
*Python*:

~~~
# name: for ... in ... : ...
# key: for
# group : control structure
# --
for ${var} in ${collection}:
    $0
~~~

More details of the customizations can be found in
the
[official documentation](https://joaotavora.github.io/yasnippet/snippet-development.html).
{: class="alert alert-info"}

### Saving the snippet

The snippet will be saved in the default snippets directory and inside
the current *major-mode* subdirectory. For example, if we attempt to
save the previous *python* snippet it will be located in
`.emacs.d/snippets/python-mode`.

### Testing the snippet

Once saved, the snippet can be tested with the command *M-x
yas-tryout-snippet* which will test the current snippet buffer
template in other buffer with the proper *major mode*.

To load the new snippet just use `M-x yas-load-snippet-buffer` and it
will be available in other buffers.

## Notes

If you are extending the snippets definitions with something that
would be useful for others, consider making
a [pull request](https://help.github.com/articles/about-pull-requests)
to the official snippets
[repo](https://github.com/AndreaCrotti/yasnippet-snippets).

## Reference

- <https://joaotavora.github.io/yasnippet/snippet-development.html>
