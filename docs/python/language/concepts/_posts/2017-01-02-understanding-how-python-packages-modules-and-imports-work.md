---
description: >
  An overview of Python's package and module systems. We take a look
  at how packages, modules and import work and how they are related.
layout: post
---

## Overview

Learning about Python's package system is fundamental for a better
understanding of how Python works and design better software.

## Background

Package support was supported first by a standard Python library
module in version 1.3 with the module ni and later, in Pyhon 1.5, was
incoporated in the interpreter.

A **module is a file** containing Python *definitions* and
*statements*. Its main goals are:

- organize code
- preventing naming conflicts

Defining a module also defines its **namespace**, i.e. "the place where a
variable is stored".

Code from other modules can be used by the process of **importing** it
in the current module. The most popular way of importing other modules
functionality is using the [import statement] `import` and passing the
[fully qualified name] of the module.

> Fully qualified name
>
>   A dotted name showing the “path” from a module’s global scope to a
>   class, function or method defined in that module, as defined in PEP
>   3155.
> 
> <footer class="blockquote-footer"> <cite>Python documentation <a href="https://docs.python.org/3/glossary.html#term-qualified-name">qualified name</a></cite></footer>
{: class="blockquote" cite="https://docs.python.org/3/glossary.html#term-qualified-name"}

> Package `import` is a method to structure Python's module namespace by
> using "dotted module names"
{: class="alert alert-info"}

For example, `import math` makes it possible to use `math` functions
in the module that imported it like `math.pi` to use the `pi`
function.

### Module Search Path

How does the *import statement* knows where the `math` module is
located?

The interpreter looks sequentially in specific locations until it finds
it[^1]:

1. Was the file passed to the interpreter?
   * **Yes** - It looks in the directory containing the input script.
   * **No** - It looks in the current directory.
2. a list of directory names specified in the [PYTHONPATH] environment
   variable
   * <small> *PYTHONPATH* augments the default search path for module files, its
     format is the same as the shell’s PATH </small>
   * `$PYTHONPATH` is typically empty and can be found with <kbd>echo $PYTHONPATH</kbd>.
3. The installation-dependent default. 
   * The actual list of folders python searches for libraries can be
     found with
		 
	 <pre class="shell">
	 <samp>
	 <span class="shell-prompt">$</span> <kbd>python3.5</kbd>
	 <span class="shell-prompt">>>> </span> <kbd>import sys</kbd>
	 <span class="shell-prompt">>>> </span> <kbd>print(sys.path)</kbd>
	 ['', '/usr/lib/python35.zip', '/usr/lib/python3.5', '/usr/lib/python3.5/plat-x86_64-linux-gnu', '/usr/lib/python3.5/lib-dynload', '/usr/local/lib/python3.5/dist-packages', '/usr/lib/python3/dist-packages']
	 <span class="shell-prompt">>>> </span>
	 </samp>
	 </pre>

[sys.path](https://docs.python.org/3/library/sys.html#sys.path) is a
list of strings that specifies the search path for
modules. Initialized from the environment variable PYTHONPATH, plus an
installation-dependent default. It can be modified using standard list
operations, adding more directories to the discover modules *paths*
`sys.path.insert(0, '/path/to/package')`
{: class="alert alert-info"}

### Packages

Packages are basically collection of modules.

> Packages are a way of structuring Python’s module namespace by using
> “dotted module names”
> 
> <footer class="blockquote-footer"> <cite>Python packages in <a
> href="https://docs.python.org/3/tutorial/modules.html#packages">official
> tutorial</a></cite></footer>
{: class="blockquote" cite="https://docs.python.org/3/tutorial/modules.html#packages"}

Besides one can just add a subdirectory to the `sys.path` list, **packages
are an elegant solution to keep related modules together**.

For example, the module name `my-package.my-module` designates a sub module named **my-module** in a
package named **my-package**.

A simple package with a *module* and two *sub packages* may look like this:

~~~
my-package/                 Top-level package
      __init__.py           Initialize package
      my-module.py
      my-subpackage/        Subpackage 
              __init__.py
              ...
      my-other-subpackage/  Subpackage
              __init__.py
              ...
~~~
   
The `__init__.py` file in each directory has two main functions:

- **Marking packages**: It marks a directory as a Python package (or
  sub package), which makes its files ending in `.py` considered
  Python modules.
- **Initialize code**: Code inside `__init__.py` is executed when the
  package is imported, but it can be empty also.

Python 3.3+ has [Implicit Namespace Packages] allowing to create
packages without `__init__.py` files.
{: class="alert alert-danger"}

## Reference

- Built-in Package Support in Python
  1.5 <http://legacy.python.org/doc/essays/packages.html>
- The Python Language Reference » The import system <https://docs.python.org/3/reference/import.html>
- [What does my PYTHONPATH contain?](http://askubuntu.com/a/385030/43253)

*[ni]: New Imports
[import statement]: https://docs.python.org/3/reference/simple_stmts.html#import
[PYTHONPATH]: https://docs.python.org/3/using/cmdline.html#envvar-PYTHONPATH
[fully qualified name]: https://docs.python.org/3/glossary.html#term-qualified-name
[^1]: <https://docs.python.org/3/tutorial/modules.html#the-module-search-path>
