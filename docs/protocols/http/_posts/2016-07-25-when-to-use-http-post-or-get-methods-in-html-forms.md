---
title: #If title is omitted, Jekyll generates a title based in the slug/filename
subtitle:
slug: 
layout: post
tags:
- http
- http-get
- http-post
- http-methods
description: > # Under 140 char. Used for meta description and main description
  What's the difference between HTTP GET and POST methods? When to use methods GET and POST in HTML forms.
weight: # order of a post relative to the same articles in a category
---

{% comment %} main content {% endcomment %}
## Overview

HTTP request methods are defined in [RFC2616 Section 9 Method Definitions](http://www.ietf.org/rfc/rfc2616.txt). 
These methods are also known as _verbs_ as <mark>they indicate the desired action to be performed on an identified resource</mark>.

## Understanding the basics in simple terms

From a practical point of view, these are the most simple (not so accurate) definitions and differences.

### GET method


> $_GET is an array of variables passed to the current script via the URL parameters.
> -- W3schools
{: cite="http://www.w3schools.com/php/php_forms.asp"}

~~~ 
/data/form?name1=value1&name2=value2 
~~~

### POST method

> $_POST is an array of variables passed to the current script via the HTTP POST method.
> -- W3schools
{: cite="http://www.w3schools.com/php/php_forms.asp"}

~~~ http
POST /data/form HTTP/1.1
Host: example.com
name1=value1&name2=value2
~~~

## When to use GET vs POST methods

In most cases:

GET should be used to __retrieve data__ from a specified resource and
sending __non-sensitive__ data.
{: class="alert alert-danger"}

POST is the preferred way for sending __form data__.
{: class="alert alert-danger"}


|-----------------+-------------------------------------------+--------------------------------------------|
|                 |                    GET                    |                   POST                     |
|-----------------|:-----------------------------------------:|:------------------------------------------:|
| Can be __cached__ | <i class="fa fa-check" aria-hidden="true"></i> | <i class="fa fa-times" aria-hidden="true"></i> |
| Remain in the __browser history__ | <i class="fa fa-check" aria-hidden="true"></i> | <i class="fa fa-times" aria-hidden="true"></i> |
| Can be __bookmarked__ | <i class="fa fa-check" aria-hidden="true"></i> | <i class="fa fa-times" aria-hidden="true"></i> |
| Used with __sensitive data__ | <i class="fa fa-times" aria-hidden="true"></i> | <i class="fa fa-check" aria-hidden="true"></i> |
| __Data length__ restrictions | <i class="fa fa-times" aria-hidden="true"></i> | <i class="fa fa-check" aria-hidden="true"></i> |
|-----------------+-------------------------------------------+--------------------------------------------|
{: class="table"}


[Source](http://www.w3schools.com/tags/ref_httpmethods.asp)

> Example: a search page should use GET, while a form that changes your password should use POST.
{: cite="http://stackoverflow.com/a/504993/1165509"}

## References

- [When should I use GET or POST method? What's the difference between them?](http://stackoverflow.com/q/504947/1165509)
- [HTTP Methods: GET vs. POST](http://www.w3schools.com/tags/ref_httpmethods.asp)
- [Methods GET and POST in HTML forms - what's the difference?](https://www.cs.tut.fi/~jkorpela/forms/methods.html)
