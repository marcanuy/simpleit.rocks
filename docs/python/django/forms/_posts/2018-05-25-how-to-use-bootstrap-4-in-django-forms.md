---
description: A simple and elegant way to add Bootstrap 4 styling to Django forms.
---

## Overview

Django provides several helpers to work with HTML forms. If you use
Bootstrap you will want to generate them using its styling classes.

## Strategy

Bootstrap forms typically use special CSS classes: `form-group`,
`form-control`, `form-check` to style each form element depending on
input type (ex: `email`, `password`, `text`, etc).

The idea is to include the above classes as attributes of the widget
used by Django.

> A widget is Django’s representation of an HTML input element. The
> widget handles the rendering of the HTML, and the extraction of data
> from a GET/POST dictionary that corresponds to the widget.
> 
> <footer class="blockquote-footer"> <cite>Widget<a href="https://docs.djangoproject.com/en/2.0/ref/forms/widgets">definition</a></cite></footer>
{: class="blockquote" cite="https://docs.djangoproject.com/en/2.0/ref/forms/widgets"}

We can customize a Django form field by explicitly defining the widget
to use and passing an `attribute` parameter defining the desired class
to render in it:

~~~ python
from django import forms

class CommentForm(forms.Form):
    comment = forms.CharField(widget=forms.Textarea(attribute="..."))
~~~

## Code

Having the following Django form consisting of `name` and `email`:

~~~ python
from django import forms

class ContactForm(forms.Form):
    name = forms.CharField(label='Your name',
                           max_length=100)
	email = forms.EmailField('Your email',
                            max_length=100)
~~~

we can customize each field CSS class to have the Bootstrap class
`form-control` by specifying it in each widget.

1. First, look what is the widget the field uses at
   <https://docs.djangoproject.com/en/2.0/ref/forms/fields/>
   
   In our example, we have to look for
   
   - [Charfield](https://docs.djangoproject.com/en/2.0/ref/forms/fields/#charfield),
   it says "*Default widget: TextInput*"
   
   -
     [EmailField](https://docs.djangoproject.com/en/2.0/ref/forms/fields/#emailfield),
     which says: "*Default widget: EmailInput*"

2. Customize widgets. For each field specify the desired widget with
   the `form-control` class.

~~~ python
from django import forms

class ContactForm(forms.Form):
    name = forms.CharField(label='Your name',
                           max_length=100,
                           widget=forms.TextInput(attrs={'class': 'form-control'}))
    email = forms.EmailField('Your email',
                            max_length=100,
                            widget=forms.EmailInput(attrs={'class': 'form-control'}))
	
~~~

## Output

Now the following template:

~~~ jinja
<div class="container">
    <div class="row">
        <div class="col-md-8">
            <form action="https://formspree.io/{{page.email}}" method="POST" role="form">
                {% if form.subject.errors %}
                <ol role="alertdialog">
                    {% for error in form.subject.errors %}
                    <li role="alert"><strong>{{ error|escape }}</strong></li>
                    {% endfor %}
                </ol>
                {% endif %}
		
                {% for field in form %}
                <div class="fieldWrapper form-group" aria-required={% if field.field.required %}"true"{% else %}"false"{% endif %}>
                    {% trans field.label_tag %}{% if field.field.required %}<span class="required">*</span>{% endif %}
                    {{ field }}
                    {% if field.help_text %}
                    <p class="help">{{ field.help_text|safe }}</p>
                    {% endif %}
                </div>
                {% endfor %}
		<input type="submit" class="btn btn-primary mb-2" value="{% trans 'Submit' %}" />
            </form>
        </div>
	<div class="col-md-4">
	    <!-- Other column -->
	</div>
    </div>
</div>

~~~

Produces the right output:

~~~ jinja
<div class="container">
    <div class="row">
        <div class="col-md-8 form-page mb-3">
            <form action="https://formspree.io/XXXXXXX.com" method="POST" role="form">
                
                <div class="fieldWrapper form-group" aria-required="true">
                    <label for="id_name">Your name:</label><span class="required">*</span>
                    <input type="text" name="name" class="form-control" maxlength="100" required id="id_name" />
                    
                </div>
                
                <div class="fieldWrapper form-group" aria-required="true">
                    <label for="id_email">Your email:</label><span class="required">*</span>
                    <input type="email" name="email" class="form-control" maxlength="100" required id="id_email" />
                    
                </div>
                
		<input type="submit" class="btn btn-primary mb-2" value="Submit" />
            </form>
        </div>
	<div class="col-md-4">
		<!-- other column -->
	</div>
</div>
~~~

## Conclusion

This is the simplest way to customize a form using Bootstrap I've found. Simple
and elegant.
