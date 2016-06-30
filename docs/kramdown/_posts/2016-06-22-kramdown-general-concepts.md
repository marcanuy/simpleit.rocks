---
title: kramdown General Concepts
subtitle: kramdown syntax
description: 
layout: post
---

* TOC
{:toc}

# Concepts #

Markdown superset converter

# Syntax #

## Blockquotes ##

Two alternatives for fully semantically correct [blockquotes](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/blockquote):

+ Adding the _cite_ attribute in _blockquote_ tag:

~~~ kramdown
> The rule of thumb is, don't introduce a new attribute outside of the __init__ method, otherwise you've given the caller an object that isn't fully initialized.
{: cite="https://jeffknupp.com/blog/2014/06/18/improve-your-python-python-classes-and-object-oriented-programming/"}
~~~

Generates the following HTML:

~~~ html
<blockquote cite="https://jeffknupp.com/blog/2014/06/18/improve-your-python-python-classes-and-object-oriented-programming/">
  <p>The rule of thumb is, don’t introduce a new attribute outside of the <strong>init</strong> method, otherwise you’ve given the caller an object that isn’t fully initialized.
</blockquote>
~~~

+ Adding a _cite_ element inside the _blockquote_

~~~ markdown
> The secret to creativity is knowing how to hide your sources. 
> -- <cite>[Albert Einstein][1]</cite>

[1]:http://www.quotedb.com/quotes/2112
~~~

Generates in HTML:

~~~html
<blockquote>
  <p>The secret to creativity is knowing how to hide your sources. 
  – <cite><a href="http://www.quotedb.com/quotes/2112">Albert Einstein</a></cite>
  </p>
</blockquote>
~~~

## Code syntax highlighting

_kramdown_ can use [rouge](https://github.com/jneen/rouge) or [Coderay](http://coderay.rubychan.de/) for [syntax highlighting](http://kramdown.gettalong.org/syntax_highlighter/coderay.html).

The language of the source code can be specified appending the name of the language after the opening line. e.g. for HTML:

+ With tildes

~~~~~~
~~~ html
<p> this is my paragraph</p>
~~~
~~~~~~

+ Using IAL

~~~~
~~~
def myfunction?
  1618
end
~~~
{: .language-ruby}
~~~~

In Jekyll also works:

+ Using backticks:

```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```

+ Or with curly braces:

{% highlight ruby %}
def foo
  puts 'foo'
end
{% endhighlight %}

### Links

+ Languages Supported <https://highlightjs.org/static/demo/>
+ Languages supported by Rouge: <https://github.com/jneen/rouge/tree/master/lib/rouge/lexers>

## Table of content generation

Kramdown can generate an automatic [Table of Contents](https://en.wikipedia.org/wiki/Table_of_contents) for all the _headers_ that have an _id_.

As by default it generates automatic _ids_ for all the header, there is only needed to add a list and name using IAL as the placeholder of the generated TOC.

~~~ markdown
* TOC
{:toc}
~~~

*[TOC]: Table Of Contents
*[IAL]: Inline Attribute List

<http://kramdown.gettalong.org/converter/html.html#toc>

References
==========

+ Documentation <http://kramdown.gettalong.org/syntax.html>
+ Quickref <http://kramdown.gettalong.org/quickref.html>

