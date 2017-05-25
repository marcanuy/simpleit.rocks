---
description: Accessing Specific Data Items from files in Jekyll's _data directory
---

## Overview

Having a sample data file, we explore some of the options we have to
access a specific item.

For the data file `projects.yml` located in `/_data/projects.yml`:

~~~yaml
- project: funtime
  url: www.funtime.url
  description: This is really fun

- project: supertime
  url: www.supertime.url
  description: This is really super
~~~

How can we access the data item whose project name is `funtime`?

# Using an index

If we know the data item index, we can access them directly, in this
case it is located in the position "0":

~~~ liquid
{{site.data.projects[0]}}
~~~

Output:

~~~
    {“project”=>”funtime”, “url”=>”www.funtime.url”,“description”=>”This is really fun”}
~~~

## Iterating

Iterating through all the data looking for an attribute

~~~ liquid
{% for item in site.data.projects %}
    {% if item.project == "funtime" %}
    {{item}}
    {% endif %}
{% endfor %}
~~~

Outputs:

    {“project”=>”funtime”, “url”=>”www.funtime.url”, “description”=>”This is really fun”}

## Changing the data file

The above data file can be optimized to make it more elegant and use
the project name as their key:

~~~ yaml
funtime:
  url: www.funtime.url
  description: This is really fun

supertime:
  url: www.supertime.url
  description: This is really super
~~~

This way we can access each of the items directly:

~~~ liquid
{{site.data.projects['funtime']}}
~~~

So it would output:

    {“url”=>”www.funtime.url”, “description”=>”This is really fun”}
