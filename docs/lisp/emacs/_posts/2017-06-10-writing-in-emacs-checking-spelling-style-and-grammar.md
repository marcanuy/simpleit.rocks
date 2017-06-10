---
description: Check the spelling and grammar of your texts with Emacs using flyspell-mode and langtool-mode.
---

## Overview

Emacs comes with several options to make your writing better by
avoiding mistakes, controlling typos and grammar, like the
ones described in the Emacs
manual:
[Checking and Correcting Spelling](https://www.gnu.org/software/emacs/manual/html_node/emacs/Spelling.html).

After getting familiar with them you will probably want to
**automatically** enable them in text modes (like markdown), and even
controlling your source code comments and strings.

This guide shows how to make it with two of the best packages for
writing:

- **[flyspell-mode]**: Flyspell enables on-the-fly spell checking, highlighting incorrect words as soon as they are completed.

- **[langtool]**: is a grammar check utility using [LanguageTool].

*LanguageTool* is <cite>an Open Source proof­reading program for
English, Spanish, and more than 20 other languages. It finds many
errors that a simple spell checker cannot detect and several grammar
problems.</cite>

After having both packages installed and properly configured, we will
activate **flyspell-mode** as soon as we load a text mode, and check
for grammatical errors each time we save the file.

## Activate flyspell-mode when loading text-modes

I find very helpful to activate `flyspell-mode` as soon as I load any
*Markdown* file, as `markdown-mode` is a derivate of `text-mode` you
can choose what works better for you. In this case I will activate it
for `text-mode`.

To load `flyspell-mode` when loading a file in any of the recognized
`text-mode`'s, we load them with:

~~~ lisp
(dolist (hook '(text-mode-hook))
    (add-hook hook (lambda () (flyspell-mode 1))))
~~~

And we can also avoid loading them in any other specific `text-mode`,
for example `change-log-mode` and `log-edit-mode`:

~~~ lisp
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
    (add-hook hook (lambda () (flyspell-mode -1))))
~~~

To also use `flyspell-mode` to check source code comments and strings there is a
special mode called `flyspell-prog-mode`, for example we can enable
for `python-mode`:

~~~ lisp
(add-hook 'python-mode-hook
    (lambda ()
    (flyspell-prog-mode)
    ))
~~~

## Check grammar after saving a text file with LanguageTools

To check a text buffer and light up errors with `langtool` we use the
`langtool-check` function each time we save the buffer using
`after-save-hook`, in this case I will activate it only for `markdown-mode`:

~~~ lisp
(add-hook 'markdown-mode-hook
          (lambda () 
             (add-hook 'after-save-hook 'langtool-check nil 'make-it-local)))
~~~


## Conclusion

In Emacs is easy to forget to check for errors manually, enabling them
automatically is a great way to minimize errors that can be avoided
easily and improving our documents legibility.

## References

- *flyspell-mode*: <https://www.emacswiki.org/emacs/FlySpell>
- *langtool*: <https://github.com/mhayashi1120/Emacs-langtool>
- *LanguageTool*: <http://languagetool.org/>
- [Trey Jackson](https://stackoverflow.com/users/6148/trey-jackson)
  answer to [How to add a hook to only run in a particular mode?](https://stackoverflow.com/a/6141681/1165509)

[flyspell-mode]: https://www.emacswiki.org/emacs/FlySpell
[langtool]: https://github.com/mhayashi1120/Emacs-langtool
[LanguageTool]: http://languagetool.org/
