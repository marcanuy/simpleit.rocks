---
title: 
subtitle: Modules versus classes in ruby
description: Modules versus Classes in Ruby
layout: post
---

## Overview

> A __Module__ in Ruby is a collection of methods and constants.
> <footer class="blockquote-footer">Ruby-doc.org</footer>
{: cite="http://ruby-doc.org/core-2.2.0/Module.html" class="blockquote"}

> __Classes__ in Ruby are first-class objects, each is an instance of class Class.
> <footer class="blockquote-footer">Ruby-doc.org</footer>
{: cite="https://ruby-doc.org/core-2.2.0/Class.html" class="blockquote"}

## Classes versus Modules

|               | Class                     | Module                          |
|:--------------|:--------------------------|:--------------------------------|
| __instantiation__ | can be instantiated       | Can *not* be instantiated       |
| __usage__ | object creation           | Mixin facility. Provides a namespace.
| __superclass__ | module                    | object                          |
| __methods__ | class methods and instance methods | module methods and instance methods |
| __inheritance__ | inherits behaviour and can be base for _inheritance_ | No _inheritance_ |
| __inclusion__ | cannot be included        | can be included in classes and  modules by using the include command (includes all instance methods as instance methods in a class/module) |
| __extension__ | can not extend with extend command (only with inheritance) | module can extend instance by using extend command (extends given instance with singleton methods from module) |
{: class="table"}

Table source: [Difference between a class and a module](http://stackoverflow.com/a/9778021/1165509)

> __Modules__ are about providing methods that you can use across multiple classes - think about them as "libraries" (as you would see in a Rails app).
>
> __Classes are about objects; modules are about functions.__
{: cite="http://stackoverflow.com/a/151774/1165509" class="blockquote"}

References
==========

+ [Ruby Class doc](https://ruby-doc.org/core-2.2.0/Class.html)
+ [Ruby Module doc](http://ruby-doc.org/core-2.2.0/Module.html)
+ [Difference between a class and a module](http://stackoverflow.com/a/9778021/1165509)

