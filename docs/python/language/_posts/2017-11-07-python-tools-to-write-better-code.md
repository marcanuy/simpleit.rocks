---
description: Python tools that helps in writing high quality code.
---

## Overview

Python community maintains a set of tools that are helpful in every
project. They provide quick feedback of your code health and how much
it sticks to standards and better practices.

These tools are:

pep8
: style checker

pyflakes
: checks source code for errors

mccabe
: complexity checker

flake8
: code checker (pep8, pyflakes, mccabe, and third-party plugins to
  check the style and quality of some python code)

Pylint
: Checks for coding standards, errors and duplicated code.

Coverage
: measure effectiveness of tests

## Tools

### Python code style (Pep8)

It was formerly called **pep8** and it checks Python coding style
conventions defined in PEP8.

Project homepage: <https://github.com/PyCQA/pycodestyle>

It is based in PEP8 style conventions
(<http://www.python.org/dev/peps/pep-0008/>).

> The guidelines provided here are intended to improve the readability
> of code and make it consistent across the wide spectrum of Python
> code. As PEP 20 says, "Readability counts". A style guide is about
> consistency. Consistency with this style guide is
> important. Consistency within a project is more important. Consistency
> within one module or function is the most important.
> 
> <footer class="blockquote-footer"> <cite><a href="https://www.python.org/dev/peps/pep-0008/">PEP8</a></cite></footer>
{: class="blockquote" cite="https://www.python.org/dev/peps/pep-0008/"}

### McCabe

McCabe is a **complexity checker for Python**.

Project homepage: <https://github.com/PyCQA/mccabe>

It is based in the **Cyclomatic complexity** concept.

> Cyclomatic complexity is a software metric (measurement), used to
> indicate the complexity of a program. It is a quantitative measure
> of the number of linearly independent paths through a program's
> source code. It was developed by Thomas J. McCabe, Sr. in 1976.
> 
> <footer class="blockquote-footer"> <cite>Wikipedia page for <a href="https://en.wikipedia.org/wiki/Cyclomatic_complexity">Cyclomatic complexity</a></cite></footer>
{: class="blockquote" cite="https://en.wikipedia.org/wiki/Cyclomatic_complexity"}

It is useful for:

- Measuring how much a program is structured
- Determining the number of test cases that are necessary to achieve
  thorough test coverage of a particular module
- Limiting complexity during development
  - Functions and methods that have the highest complexity tend to also
  contain the most defects.
- Measure modules cohesion through the analysis of its complexity.

### Error checks: Pyflakes

It checks Python source files for errors by parsing source code.

Project homepage: <https://github.com/PyCQA/pyflakes>

### All together: Flake8

Project Homepage: <https://gitlab.com/pycqa/flake8>

Flake8 runs all the above tools with the `flake8` command.

#### Pylint

Project Homepage: <https://www.pylint.org/>

### Code Coverage

It measures code coverage of Python projects.

Project Homepage: <http://coverage.readthedocs.io/en/latest/>

> It monitors your program, noting which parts of the code have been
> executed, then analyzes the source to identify code that could have
> been executed but was not.
>
> Coverage measurement is typically used to gauge the effectiveness of
> tests. It can show which parts of your code are being exercised by
> tests, and which are not.
> 
> <footer class="blockquote-footer"> <cite><a href="http://coverage.readthedocs.io/en/latest/">Coverage.py project</a></cite></footer>
{: class="blockquote" cite="http://coverage.readthedocs.io/en/latest/"}

## References

- <https://mail.python.org/mailman/listinfo/code-quality/>
- <https://en.wikipedia.org/wiki/Cyclomatic_complexity>
