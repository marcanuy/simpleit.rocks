---
title: 
subtitle: How to decide between Test-driven development and write code first
layout: post
---

## Overview

The optimal solution when testing a web application while developing is a
mix between _Test-driven development_ and _write code first_.

Test Driven Development code concept is to write tests before
implementations:

1. Write a test that fails
2. Make the test pass changing the code, without breaking other tests
3. Refactor the code, verify that tests pass

TDD methodology makes you write a lot of code for simple tasks and can 
often make you lost focus on what you are trying to develop.

A balanced approach is to use the __TDD methodology__ in certain cases and
__write first code__ in others, or sometimes to skip tests at all,
these are some hints on how to choose between them:

|Scenario|TDD|Code first|
|:-----:|:------:|:-----:|
|Is the test very short or simple?|<i class="fa fa-check" aria-hidden="true"></i>||
|Don't knowing the desired behaviour yet?||<i class="fa fa-check" aria-hidden="true"></i>|
|Does it has something to do with the security model?|<i class="fa fa-check" aria-hidden="true"></i>||
|Fixing a bug?|<i class="fa fa-check" aria-hidden="true"></i>||
|Are you refactoring?|<i class="fa fa-check" aria-hidden="true"></i>||
{: class="table"}

> Whenever a bug is found, write a test to reproduce it and protect against regressions, then write the application code to fix it.
> <footer class="blockquote-footer">Rails Tutorial Book</footer>
{: class="blockquote" cite="https://www.railstutorial.org/book/static_pages"}

Do not write test code for code that it is likely to change, like detailed HTML.
{: class="alert alert-danger"}

## In a MVC approach

For __controllers__ and __models__ write tests first (TDD), then integration tests.

For __views__ that we know are constantly changing and are not so prone to errors, skip testing.

As always, it ultimately depends on each case, there aren't solutions
that can be always applied, it ends up being a mix between trial and error
to see what gives you the best balance between being productive and
generating that sense of confidence in your code that writing tests gives,
a lot of practice is required to achieve a smooth integration of writing
tests and code.

## References

+ [Ruby on Rails Tutorial]({% link _books/ruby-on-rails-tutorial.md %})

