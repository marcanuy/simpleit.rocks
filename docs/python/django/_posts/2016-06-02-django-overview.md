---
title: Django Overview
subtitle: Framework basic summary
description: Python Web framework ovewview
layout: post
weight: 1
---

# Concepts

Each Django _project_ can be composed of many _apps_. An _app_ is a small
project that should focus on performing one task (e.g. A website project
can have: a blog, ratings, news apps).

# Django project structure

Django by default creates a directory structure suitable for basic 

<pre>
.
└── mysite/
    ├── manage.py
    ├── mysite/
    |   ├── __init__.py
    |   ├── settings.py
    |   ├── urls.py
    |   └── wsgi.py
    └── myapp/
        ├── __init__.py
        ├── admin.py
        ├── apps.py
        ├── migrations/
        ├── __init__.py
        ├── models.py
        ├── tests.py
        ├── urls.py
        └── views.py
</pre>

The structure that sets up Django by default is very basic, when a project
starts to grow, it starts to require a robust approach that deals better
with core aspects of development and deployment such as:

- deployment scripts
- separated tests by units
- having different environments for development, production (staging)
- documentation for the project

[Two Scoops Of Django] recommends the following structure: ( implemented in [Cookiecutter](https://github.com/pydanny/cookiecutter-django))

#keep venv outside project structure
#/.virtualenvs/<django_project_name>/

<pre>
...
.
└── REPO-ROOT #git repo
    ├── README.rst
    ├── docs
    ├── .gitignore
    ├── requirements
    │   ├── base.txt
    │   ├── local.txt
    │   ├── production.txt
    │   └── test.txt
    ├── Makefile # Deployment tasks
    └── PROJECT-ROOT
        ├── manage.py
        ├── media 
        ├── static
        ├── templates # site-wide
        ├── APP-1
        ├── APP-2
        └── CONFIGURATION-ROOT
            ├── __init.py__
            ├── settings
            │   ├── __init.py__
            │   ├── base.py
            │   ├── local.py
            │   └── production.py
            ├── urls.py
            └── wsgi.py
</pre>


_media_ directory should exists only in development, for user generated 
static media assets (e.g. photos). 
_repo-root/<django-project-root>/static_ non user generated static media 
assets (e.g. css) controlled by STATICFILES DIRS config variable.
__Media__ and __static__ directories in production should be located in 
a static media server.
{: class="alert alert-warning"}

## Models 

Fat models, thin views.

## Views

* Generic views <https://docs.djangoproject.com/en/1.9/topics/class-based-views/generic-display/>

* Model forms <https://docs.djangoproject.com/en/1.9/topics/forms/modelforms/>

## Templates

## Testing

* <https://docs.djangoproject.com/en/1.9/topics/testing/>
* Assertions available are from _unittest_ and from Django's _TestCase_
so the full list of _assertions_ available are:
    * <https://docs.djangoproject.com/en/dev/topics/testing/tools/#assertions>
	* <https://docs.python.org/3/library/unittest.html#assert-methods>

> The preferred way to write tests in Django is using the
[unittest](https://docs.python.org/3/library/unittest.html#module-unittest) 
module built in to the Python standard library
{: cite="https://docs.djangoproject.com/en/1.9/topics/testing/"}

> In Django we subclasses from django.test.TestCase, which is a subclass of
unittest.TestCase that runs each test inside a transaction to provide 
isolation.
{: cite="https://docs.djangoproject.com/en/1.9/topics/testing/overview/"}

> Django provides a [test Client](https://docs.djangoproject.com/en/1.9/intro/tutorial05/#the-django-test-client) 
to simulate a user interacting with the code at the view level. We can use
it in tests.py

### Related Links

* Testing tutorial <https://docs.djangoproject.com/en/1.9/topics/testing/>

## Admin

* Edit models on the same page as a parent model with Model Inlines
<https://docs.djangoproject.com/en/dev/ref/contrib/admin/#inlinemodeladmin-objects>

References
==========

+ Official Documentation in categories <https://docs.djangoproject.com/en/>
+ Single page with links to each doc <https://docs.djangoproject.com/en/1.9/contents/>

## Books
	
+ [Two Scoops Of Django]({% link _books/two-scoops-of-django.md %})

[Two Scoops Of Django]: {% link _books/two-scoops-of-django.md %}

*[ORM]: Object Relational Mapping
