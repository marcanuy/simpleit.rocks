---
title:
subtitle: 
description: Handle Ruby's gem versions for each project.
layout: post
---

## Overview

Manage gem versions consistently accross platforms.

### Bundler

> Bundler provides a consistent environment for Ruby projects by tracking and installing the exact gems and versions that are needed. 
> <footer class="blockquote-footer">Bundler project</footer>
{: class="blockquote" cite="http://bundler.io/"}

#### Bundler common workflow

+ Declare dependencies of an application in a [Gemfile](http://bundler.io/gemfile.html)
+ [Install](http://bundler.io/bundle_install.html) above versions of the dependencies into an isolated location `bundle install`
+ run the app: `bundle exec`

References
==========

+ <https://www.bundler.io/>

*[ORM]: Object Relational Mapping
