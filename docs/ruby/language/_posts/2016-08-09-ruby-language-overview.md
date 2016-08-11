---
title: Ruby Language Overview
subtitle: Ruby Basic Concepts
description: Ruby programming language basic concepts.
layout: post
---

Ruby Console (Interactive Ruby): <kbd>irb</kbd>

Everything in Ruby, including _nil_ and _strings_, is an __object__
{: class="alert alert-info"}

## Modules

Related methods in Ruby can be packaged in _modules_.

Modules are often explicitly imported or they can be imported
_automagically_ in frameworks that favours conventions like 
_ruby on rails_.

~~~ ruby
module ApplicationHelper
	# ....
end

~~~


## Method definition

By convention, every method that ends with a question mark `?` returns a _boolean_ value.

<pre class="shell">
<samp>
<span class="shell-prompt">irb(main):></span> <kbd>"".empty?</kbd>
=> true
</samp>
</pre>

Defining a method with `def`:

~~~ ruby
def message(str = '')
  return "empty string!" if str.empty?
  return "nonempty."
end
~~~

## Comments

Comments start with the hash mark `#` (also called the _pound sign_ and the _octothorpe_)

~~~ ruby
# This is a comment in ruby
~~~

## Local variable assignment

## Booleans

## Comparisons

- Equality comparison operator `==`
- Not equal comparison operator `!=`

## Control flow

### Conditional clause (if)

`if-elsif-end`

<pre class="shell">
<samp>
<span class="shell-prompt">irb(main):></span> <kbd>if "".empty? && !"a".empty? || "".length==0 </kbd>
<span class="shell-prompt">irb(main):></span> <kbd>  puts "YOLO"</kbd>
<span class="shell-prompt">irb(main):></span> <kbd>elsif !"".empty?</kbd>
<span class="shell-prompt">irb(main):></span> <kbd>  puts "That is not YOLO"</kbd>
<span class="shell-prompt">irb(main):></span> <kbd>end</kbd>
YOLO
=> nil
<span class="shell-prompt">irb(main):></span> <kbd>puts "Hello" if "".empty?</kbd>
Hello
=> nil
</samp>
</pre>


## Strings

Strings in Ruby are specified with _double quotes_ `"a string"` or _single quotes_`'another string'`.
The main [difference]({% link docs/ruby/language/_posts/2016-08-09-double-versus-single-quotes-in-ruby.md %}) between them is that __double quotes__ allows __string interpolation__ `"Hello #{name}"` and __escape sequences__ `"\n"` so it is encouraged to use them.

__String concatenation__ is done with `+` sign: `"foo" + "bar"` or with __interpolation__:

<pre class="shell">
<samp>
<span class="shell-prompt">irb(main):></span> <kbd>sport="running"</kbd>
=> "running"
<span class="shell-prompt">irb(main):></span> <kbd>"keep #{sport}"</kbd>
=> "keep running"
</samp>
</pre>

### Printing

To print a string there is the command `puts` and `print`.

The command `puts` stands for __put string__ and is used to print strings.

`puts` includes a _new line_ after showing the content and does not 
return anything (__nil__).
{: class="alert alert-warning"}

<pre class="shell">
<samp>
<span class="shell-prompt">irb(main):></span> <kbd>print "foobar"</kbd>
foobar=> nil
<span class="shell-prompt">irb(main):></span> <kbd>puts "foobar"</kbd>
foobar
=> nil
<span class="shell-prompt">irb(main):></span> <kbd>print "foobar\n"</kbd>
foobar
=> nil
</samp>
</pre>

## Return values

## Data structures

### Arrays

~~~ ruby
a = ["foo", "bar", "baz"]
~~~

- Access specific array position
  - `a[0]`
  - `a.first`


References
==========

+ Official Documentation <https://www.ruby-lang.org/>
+ Docs and API <http://ruby-doc.org/>

