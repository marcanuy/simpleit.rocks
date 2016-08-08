---
title: Appropriate HTML5 tags to show source code, commands and software related tasks on blogs
subtitle:
slug: 
layout: post
tags:
- html5
- web-development
- code
description: > # Under 140 char. Used for meta description and main description
  Set of HTML5 tags recommended to show code and commands in a webpage.
---

{% comment %} main content {% endcomment %}
## Overview

HTML5 provides a set of tags that can be used to represent code, 
commands and anything related with software development.

The content that any tech related blog will contain would tipipcally be:

- Text with whitespaces: `<pre>`
- Software __Code__ examples: `<code>`
  - Refering to __variables__ in any paragraph: `<var>`
- Displaying __User Input__ `<kbd>`
- Showing __Computer Output__ `<samp>`

## Whitespaces

Many languages give whitespaces a special meaning, they can be used 
to convey a program's structure or be a core part of a programming
language that adhere to the _off-side_ rule.

Leading indentation in these cases should be respected when showing
content.

> A computer programming language is said to adhere to the
> __off-side rule__ if blocks in that language are expressed by 
> their indentation
{: cite="https://en.wikipedia.org/wiki/Off-side_rule"}

The `pre` element is defined as follows:

> `<pre>` element represents a block of preformatted text, 
> in which structure is represented by typographic conventions 
> rather than by elements.
> - W3
{: cite="https://www.w3.org/TR/html5/grouping-content.html#the-pre-element"}

It is useful to show _fragments of computer code_ or any text 
that needs to preserve whitespaces like ASCII art or directory trees:

### Example

The following text using `<pre>`

~~~ 
<pre>
.
├── config.yml
└── drafts
    ├── begin-with-the-crazy-ideas.textile
    └── on-simplicity-in-technology.markdown
</pre>
~~~

produces:

<pre>
.
├── config.yml
└── drafts
    ├── begin-with-the-crazy-ideas.textile
    └── on-simplicity-in-technology.markdown
</pre>

Without `<pre>`:

<samp>
.
├── config.yml
└── drafts
    ├── begin-with-the-crazy-ideas.textile
    └── on-simplicity-in-technology.markdown
<samp>


## Code

Fragment of computer code can be represented with the `<code>` element.

It can be used to represent:

- file names
- source code
- any string that a computer would recognize

When used with `<pre>` it can show source code conserving whitespaces,
useful to represent source code from languages like _python_.

### Example

The following source using `<pre>` and `<code>`:

~~~ html
<pre>
<code>
 if foo:
     if bar:
         print(bar)
 else:
   print(foo)
</code>
</pre>
~~~

Will be displayed as:

<pre>
<code>
 if foo:
     if bar:
         print(bar)
 else:
   print(foo)
</code>
</pre>

Without `pre` and `code`: 

<samp>
 if foo:
     if bar:
         print(bar)
 else:
   print(foo)
</samp>

## Variables

> The var element represents a variable. This could be an actual variable 
> in a mathematical expression or programming context, an identifier
> representing a constant, a symbol identifying a physical quantity, 
> a function parameter, or just be a term used as a placeholder in prose.
{: cite="https://www.w3.org/TR/html5/text-level-semantics.html#the-var-element"}

Example: The letter "n" is being used as a variable in prose:

~~~ html
<p>If there are <var>n</var> pipes leading to the ice
cream factory then I expect at <em>least</em> <var>n</var>
flavors of ice cream to be available for purchase!</p>
~~~

Outputs:

<samp>
If there are <var>n</var> pipes leading to the ice
cream factory then I expect at <em>least</em> <var>n</var>
flavors of ice cream to be available for purchase!
</samp>

## Computer Output

Computer output can be 

> The samp element represents (sample) output from a program or computing system.
{: cite="https://www.w3.org/TR/html5/text-level-semantics.html#the-samp-element"}

### Console Commands

A sequence of commands introduced in a termianl can be represented with `samp`, 
for example: 

~~~
<pre class="shell">
<samp>
<span class="shell-prompt">john@server:~$</span> <kbd>ssh nasa.com</kbd>
Last login: Tue Apr 5 07:11:05 2010 from mars.com on pts/1
Linux nasa 2.6.11-grsec-v6.189 #1 SMP Tue Feb 1 12:21:05 PST 2010 i586 

<span class="shell-comment"># I'm in</span>
<span class="shell-prompt">john@nasa:~$</span> <span class="shell-cursor">_</span>
</samp>
</pre>
~~~

Outputs (with proper *CSS*):

<pre class="shell">
<samp>
<span class="shell-prompt">john@server:~$</span> <kbd>ssh nasa.com</kbd>
Last login: Tue Apr 5 07:11:05 2010 from mars.com on pts/1
Linux nasa 2.6.11-grsec-v6.189 #1 SMP Tue Feb 1 12:21:05 PST 2010 i586

<span class="shell-comment"># I'm in</span>
<span class="shell-prompt">john@nasa:~$</span> <span class="cursor">_</span>
</samp>
</pre>

## User Input

The element to represent _user input_ is `kbd`.

This element is useful to represent:

- terminal commands
- keyboard input
- voice commands

## Examples and nesting:

### Input echoed

`<samp><kbd>..</kbd></samp>` represents the input as it was echoed by the system.

###  Input based on something

- `<kbd><samp>..</samp></kbd>` represents input based on system output, for example invoking a menu item.

> the samp elements inside them indicating that the steps are input based on something being displayed by the system

Example: The following code 

~~~ html
<p>
	To save it, select
	<kbd>
	  <kbd>
		  <samp>File</samp>
	  </kbd>
	  |
	  <kbd>
		  <samp>Save...</samp>
	  </kbd>
	</kbd>
</p>
~~~

Outputs:

<samp>
	To save it, select
	<kbd>
	  <kbd>
		  <samp>File</samp>
	  </kbd>
	  |
	  <kbd>
		  <samp>Save...</samp>
	  </kbd>
	</kbd>
</samp>

### Key press

- `<kbd><kbd>..<kbd></kbd>` represents an actual key or other single unit of input.

Example: To indicate keys to press: 

`<p>To continue press <kbd><kbd>Ctrl</kbd>+<kbd>Space</kbd></kbd></p>`

Woulde produce the following output:

<samp>
<p>To continue press <kbd><kbd>Ctrl</kbd>+<kbd>Space</kbd></kbd></p>
</samp>

- <https://www.w3.org/TR/html5/text-level-semantics.html#the-kbd-element>

## References

- <https://www.w3.org/TR/html5/grouping-content.html#the-pre-element>
- <https://www.w3.org/TR/html5/text-level-semantics.html#the-code-element>
- <https://www.w3.org/TR/html5/text-level-semantics.html#the-samp-element>
- <https://www.w3.org/TR/html5/text-level-semantics.html#the-kbd-element>
- <https://www.w3.org/TR/html5/text-level-semantics.html#the-var-element>
