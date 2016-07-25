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

A typical Django project, at first, has a very basic layout. After following
_Django docs_ suggestions, like creating the project
`$ django-admin startproject my_project` and some _app_
`$ python manage.py startapp my_app` will create the following structure:

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


Default settings are located in `django/conf/global_settings.py`, they are
overwritten in `mysite/settings.py`
{: class="alert alert-info"}

The structure that sets up Django by default is very basic, when a project
starts to grow, it starts to require a better approach, outlined in
{% link docs/python/django/_posts/2016-07-16-django-project-directory-structure.md %}
that deals with other aspects of development and deployment such as:

- deployment scripts
- separated tests by units
- having different environments for development, production (staging)
- documentation for the project

## Models 

Fat models, thin views.

## Views

* Generic views <https://docs.djangoproject.com/en/1.9/topics/class-based-views/generic-display/>

## Templates

## Forms

In a Django web app, a form can refer to:

- an [HTML form](https://www.w3.org/TR/html5/forms.html#forms) a component of a Web page that has form controls
- a [Django Form](https://docs.djangoproject.com/en/1.9/ref/forms/api/#django.forms.Form) that produces an HTML form
- the structured data returned when a form is submitted
- all of the above interacting together

Reference: <https://docs.djangoproject.com/en/1.9/topics/forms/>

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

+ [Two Scoops Of Django]({% link _books/two-scoops-of-django.md %})
+ Official Documentation in categories <https://docs.djangoproject.com/en/>
+ Single page with links to each doc <https://docs.djangoproject.com/en/1.9/contents/>

*[ORM]: Object Relational Mapping
