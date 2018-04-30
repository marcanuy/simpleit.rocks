---
description: Notes on Django forms. A quick overview to show Django forms basic concepts.
---

## Overview

Django provides several classes to facilitate the work of creating
forms. This article's goal is to ease the understanding of how Django
forms work and show an example of its basic usage, prior to reading
the official documentation.

## Introduction

An HTML form is defined by `<form>...</form>` tags. The elements between
them allow visitors to perform several tasks like enter text, select
options and manipulate objects, and finally then send that information
back to the server.

In Django, form interface elements can be plain HTML basic elements
like checkboxes or text input, or complex elements like pop ups, date
pickers, etc.

Django forms helps with three main task:

1. Preparing and restructuring data to make it ready for rendering
  - data of several different types may need to be prepared for display in a form
2. Creating the actual HTML forms for the data 
  - Rendering data as HTML elements
  - Creating interfaces to edit data
3. Receiving and processing submitted forms and data from the client
  - Return data to the server
  - Validate, clean and save data
  - Pass it for further processing

So a form in this context could refer to:

- HTML `<form>`: <https://www.w3.org/TR/html51/sec-forms.html#sec-forms>
- A Django form, a declaration that extends from `django.forms.Form`
  class that produces the HTML form:
  <https://docs.djangoproject.com/en/2.0/ref/forms/api/#django.forms.Form>
  - it is used to describe a form
  - specify how it works
  - specify how it appears
  
One of the most used features of Django forms, is the ability to
generate an HTML form from Django Models, it process model fields, and
generate an HTML `<input>` element for each field in a Form.

Each form field is generated in the browser by an user interface
element called *widget*,

## Methods

GET and POST are the only HTTP methods to use when dealing with forms.

### POST method

This is what happens in form using a POST method:

<div class="mermaid">
graph TD
   bundle(browser bundles up the submitted form data)
   encode(encodes data for transmission)
   bundle  --> encode
   server(sends it to the server)
   encode --> server
   response(receives back its response)
   server --> response
</div>

While in GET method information is transmitted without encoding it:

<div class="mermaid">
graph TD
   bundle(browser bundles up the submitted form data into a string)
   url(use data to compose a URL)
   bundle  --> url
   server(sends it to the server)
   url --> server
   response(receives back its response)
   server --> response
</div>

## Building a form

To use Form instances, we should use the web form, described by a
Django Form, processed by a view, and rendered as an HTML <form>.:

- **validate data**: if `form.is_valid()` then form's data will
populate the `cleaned_data` attribute.

- **process the view**: it can be the same view which published the
  form or another one. For example in a view that generates and
  process a form the process would be:
  
<div class="mermaid">
graph TD
   view(A view receives a request)
   request{if request.method}
   view --> request
   request -->|POST| create("create form binding data to it: form = MyForm(request.POST)")
   create -->  D{"form is_valid()"}
   D --> populate("process the data in form.cleaned_data")
   request -->|GET| E["Create a new form instance"]
   E --> F("Render view")
</div>

The form could have data or not, depending if it has been prepopulated
or if there was any error when processing it. Associating data to form
fields is called **binding data to the form**.

To check if a form has data bound to it there is the method
[django.forms.Form.is_bound()](https://docs.djangoproject.com/en/2.0/ref/forms/api/#django.forms.Form.is_bound).





## References

- <https://docs.djangoproject.com/en/2.0/topics/forms/>

