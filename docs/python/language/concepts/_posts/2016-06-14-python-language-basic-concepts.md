---
title: Python Language Basic Concepts
layout: post
---

* _Style guide_ for python code PEP-8 <https://www.python.org/dev/peps/pep-0008/>
  * Tools to help in formatting Python code:
	* [pep8](https://pypi.python.org/pypi/pep8) checks your Python code against some of the style conventions.
	* [autopep8](https://pypi.python.org/pypi/autopep8) automatically formats Python code to conform to the PEP 8 style guide.
  
* Relative imports makes code more portable. 

  * _absolut import_ `from core.views import absolute` <---  To import from outside the app
  * _explicit relative_ `from .models import CommandModel` <--- To import in current app 

* Avoid Using `Import *` as it can lead to undesirable results. You can't really know which packages you are using.

