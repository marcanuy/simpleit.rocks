---
title: 
subtitle: Difference between
description: Difference between using double quotes and single quotes in ruby
layout: post
---

Strings in Ruby are specified with _double quotes_ `"a string"` or _single quotes_`'another string'`.
The main [difference](http://stackoverflow.com/q/6395288/1165509) is that __double quotes__ allows:

- __string interpolation__: 

~~~ ruby
name = 'John'
"Hello #{name}"
~~~

- __escape sequence__ :

<pre class="shell">
<samp>
<span class="shell-prompt">irb(main):></span> <kbd>puts "a\nb"</kbd>
a
b
=> nil
<span class="shell-prompt">irb(main):></span> <kbd>puts 'a\nb'</kbd>
a\nb
=> nil
</samp>
</pre>

