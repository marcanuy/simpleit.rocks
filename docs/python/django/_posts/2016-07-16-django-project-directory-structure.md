---
title: #If title is omitted, Jekyll generates a title based in the slug/filename
subtitle:
slug: 
layout: post
tags:
- django
- directory-structure
- project-structure
- web-development
description: > # Under 140 char. Used for meta description and main description
  An approach on the most convenient way to organize directories for robust Django projects.
---

## Overview

The structure that sets up Django by default is very basic, when a project
starts to grow, it starts to require a better approach, that deals with 
other aspects of development and deployment such as:

- deployment scripts
- separated tests by units
- having different environments for development, production (staging)
- documentation for the project

## Recommended Django directory structure

- REPO-ROOT `git repo`
  - README.rst
  - docs
  - .gitignore
  - [requirements]({% link docs/python/django/_posts/2016-06-10-custom-django-configurations-for-different-servers.md %})
      - base.txt
      - local.txt
      - production.txt
      - test.txt
  - Makefile `Deployment tasks`
  - PROJECT-ROOT
    - manage.py
    - media 
    - static
    - templates `site-wide`
    - APP-1
    - APP-2
    - CONFIGURATION-ROOT
      - __init.py__
      - [settings]({% link docs/python/django/_posts/2016-06-10-custom-django-configurations-for-different-servers.md %})
        - __init.py__
        - base.py
        - local.py
        - production.py
    - urls.py
    - wsgi.py

Keep [virtual environment outside project]{% link docs/python/django/_posts/2016-06-10-custom-django-configurations-for-different-servers.md %}
`/.virtualenvs/<django_project_name>/`
{: class="alert alert-danger"}

_media_ directory should exists only in development, for user generated 
static media assets (e.g. photos). 
_repo-root/<django-project-root>/static_ non user generated static media 
assets (e.g. css) controlled by STATICFILES DIRS config variable.
__Media__ and __static__ directories in production should be located in 
a static media server.
{: class="alert alert-warning"}

[Two Scoops Of Django] has the project structure they recommend implemented in the project [Cookiecutter](https://github.com/pydanny/cookiecutter-django).
{: class="alert alert-info"}

## References

- [Recommended Django Project Layout by Revsys](http://www.revsys.com/blog/2014/nov/21/recommended-django-project-layout/)
- [Two Scoops Of Django]
- [StackOverflow - Best practice for django project working directory structure](http://stackoverflow.com/a/23469321/1165509)
- [StackOverflow - Django directory structure?](http://stackoverflow.com/a/11222631/1165509)
- [Starting a Django 1.6 Project the Right Way by Jeff Knupp](http://jeffknupp.com/blog/2013/12/18/starting-a-django-16-project-the-right-way/)
- wildfish-django-starter <https://github.com/wildfish/wildfish-django-starter>
- Django project starter <https://github.com/arocks/edge>
- django-project-skeleton 
  - <http://django-project-skeleton.readthedocs.io/en/latest/structure.html>
  - <https://github.com/Mischback/django-project-skeleton>

[Two Scoops Of Django]: {% link _books/two-scoops-of-django.md %}
