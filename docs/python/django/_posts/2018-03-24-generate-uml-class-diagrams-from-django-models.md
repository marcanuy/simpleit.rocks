---
title: Generate UML class diagrams from django models
description: How to generate class diagrams pictures in a Django project from console
---

## Overview

To visualize and better understand a project structure we can create
UML class diagrams from Django models.

> a class diagram in the Unified Modeling Language (UML) is a type of
> static structure diagram that describes the structure of a system by
> showing the system's classes, their attributes, operations (or
> methods), and the relationships among objects.
> 
> <footer class="blockquote-footer"> <cite><a href="https://en.wikipedia.org/wiki/Class_diagram">Wikipedia</a></cite></footer>
{: class="blockquote" cite="https://en.wikipedia.org/wiki/Class_diagram"}

*[UML]: Unified Modeling Language

We will use a special command for this task included in the
[django-extensions](https://github.com/django-extensions/django-extensions)
package called:
[graph_models](https://django-extensions.readthedocs.io/en/latest/graph_models.html)

> Creates a GraphViz dot file for the specified app names based on
> their models.py. You can pass multiple app names and they will all
> be combined into a single model. Output is usually directed to a dot
> file.
>
> <footer class="blockquote-footer"> <cite><a
href="https://django-extensions.readthedocs.io/en/latest/graph_models.html">Graph
models</a> definition</cite></footer>
{: class="blockquote" cite="https://django-extensions.readthedocs.io/en/latest/graph_models.html"}

## Steps

### Install django extensions

Considering you already have Django installed (for this example I will
use the [Wagtail](https://github.com/wagtail/wagtail) project), then
we install *django extensions* with <kbd>pip install
django-extensions</kbd>.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>pip install django-extensions</kbd>
Collecting django-extensions
  Using cached django_extensions-2.0.6-py2.py3-none-any.whl
Collecting six>=1.2 (from django-extensions)
  Using cached six-1.11.0-py2.py3-none-any.whl
Installing collected packages: six, django-extensions
Successfully installed django-extensions-2.0.6 six-1.11.0
</samp>
</pre>

### Add to installed apps

To make your Django project aware of the new package, we add it to
`INSTALLED_APPS` in your configuration file `<project>/settings.py`,
in a Wagtail project called `mysite` this is at
`mysite/settings/base.py`:

~~~ python
INSTALLED_APPS = (
    ...
    'django_extensions',
    ...
)
~~~

### Install diagrams generators

You have to choose between two diagram generators:

- Graphviz or
- Dotplus

before using the command or you will get:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>python manage.py graph_models -a -o myapp_models.png</kbd>
CommandError: Neither pygraphviz nor pydotplus could be found to generate the image
</samp>
</pre>

I prefer to use `pydotplus` as it easier to install than Graphviz and
its dependencies so we use <kbd>pip install pydotplus</kbd>.

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>pip install pydotplus</kbd>
Collecting pydotplus
Collecting pyparsing>=2.0.1 (from pydotplus)
  Using cached pyparsing-2.2.0-py2.py3-none-any.whl
Installing collected packages: pyparsing, pydotplus
Successfully installed pydotplus-2.0.2 pyparsing-2.2.0
</samp>
</pre>

### Generate diagrams

Now we have everything installed and ready to generate diagrams using
the command <kbd>python manage.py graph_models</kbd>

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>python manage.py graph_models -a -o myapp_models.png</kbd>
</samp>
</pre>

This will give use the entire Wagtail class diagram:

![Wagtail models class diagram](/assets/img/wagtail_models.png){:class="img-fluid"}

Or grouped by application (`-o`):

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>./manage.py graph_models -a -g -o my_project_visualized.png</kbd>
</samp>
</pre>

![Wagtail models class diagram grouped by app](/assets/img/wagtail_models_application_grouping.png){:class="img-fluid"}

Lastly, let's generate a class diagram for Django (v2.0.3) models:

![Django models class diagram grouped by app](/assets/img/django_models.png){:class="img-fluid"}

## Conclusion

Besides you probable have done the class diagram before starting the
project, it can easily get outdated after a while. This is a useful
technique to keep your diagrams in sync with the current status of the
project.

Have a look at
<https://django-extensions.readthedocs.io/en/latest/graph_models.html>
for a full description of `graph-models` options.

## References

- <https://github.com/django-extensions/django-extensions>
