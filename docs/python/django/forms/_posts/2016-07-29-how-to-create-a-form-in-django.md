---
title: 
subtitle: Typical workflow for creating a Django web form
description: Django simplify and automates the process to create a form in simple steps.
layout: post
---

## Overview

A tipical workflow when creating a form in Django consists of these three steps:

<div class="mermaid">
graph TB
  a[Create a Form class that defines its fields]-->b
  b[Create the view to display the form and process received data]-->c
  c[create the template to show the form]
</div>

## Creating the form 

A _form_ can be defined [from scratch](https://docs.djangoproject.com/en/1.9/topics/forms/) 
or take the field defitions from [Model](https://docs.djangoproject.com/en/1.9/topics/forms/modelforms/) classes.

<div class="mermaid">
graph TB
  form-->has_model{"from a model"}
  has_model-- no -->scratch["Inherits from django.forms.Form"]
  has_model-- yes -->model["Inherits from django.forms.ModelForm"]
  scratch-->fields["Define fields using django.forms.*Field"]
</div>

### New Form

~~~ python
# forms.py
from django import forms

class ContactForm(forms.Form):
    name = forms.CharField(label='Full name', max_length=70)
~~~

### From Model

~~~ python
from django.forms import ModelForm
from myapp.models import News

class ArticleForm(ModelForm):
    class Meta:
        model = News
    fields = ['title', 'content']
~~~

Creating an empty form to add an article.

~~~ python
form = ArticleForm()
~~~

Creating a form to change an existing article.

~~~ python
article = Article.objects.get(pk=1)
form = ArticleForm(instance=article)
~~~


## References

- Forms API <https://docs.djangoproject.com/en/1.9/ref/forms/api/#module-django.forms>
- Forms tutorial <https://docs.djangoproject.com/en/1.9/topics/forms/>
- New Forms <https://docs.djangoproject.com/en/1.9/topics/forms/>
- Forms from models <https://docs.djangoproject.com/en/1.9/topics/forms/modelforms/>
