---
description: How to list all files in a new directory when checking the git status instead of just seeing the directory name
layout: post
---

## Overview

If you create a directory in a repo and start adding files, when you
check the repository status with <kbd>git status</kbd>, by default it
will just list the new directory and not its files.

Using a special parameter in `git status` we can see all the files
in the new directory we want to **stage**.

## Seeing untracked files

`git status` has the `untracked-files` switch where we select which
files to see each time we execute `git status`.



> The mode parameter is used to specify the handling of untracked files. It is optional: it defaults to all, and if specified, it must be stuck to the option (e.g. -uno, but not -u no).
> 
> The possible options are:
> 
>     no - Show no untracked files.
> 
>     normal - Shows untracked files and directories.
> 
>     all - Also shows individual files in untracked directories.
> 
> <footer class="blockquote-footer"> <cite>git-status <a href="https://git-scm.com/docs/git-status">documentation</a></cite></footer>
{: class="blockquote" cite="https://git-scm.com/docs/git-status"}

Using the `--untracked-files=all` we see all the files in new
directories.

I will create a new directory with some untracked files to see its behaviour:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>mkdir new_feature</kbd>
<span class="shell-prompt">$</span> <kbd>touch new_feature/feature_a</kbd>
<span class="shell-prompt">$</span> <kbd>touch new_feature/feature_b</kbd>
<span class="shell-prompt">$</span> <kbd>git status</kbd>
On branch master

Initial commit

Untracked files:
  (use "git add \<file\>..." to include in what will be committed)

	new_feature/

nothing added to commit but untracked files present (use "git add" to track)
</samp>
</pre>

## Showing untracked files

Using `git status untracked-files=all`:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>git status --untracked-files=all</kbd>
On branch master

Initial commit

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	new_feature/feature_a
	new_feature/feature_b

nothing added to commit but untracked files present (use "git add" to track)
</samp>
</pre>

Now we can stage new files directly.

## Setting as the default behaviour

To save this setting, we use `git config --global
status.showuntrackedfiles all` so it will add the following to git
configuration in `~/.config`:

~~~
[status]
	showuntrackedfiles = all
~~~

Or we can just add the above code manually to `~/.config`.

## References

- Git status documentation <https://git-scm.com/docs/git-status#git-status--ultmodegt>
- [Choose files to stage of a new directory with magit in Emacs](http://emacs.stackexchange.com/q/13729/8563)
