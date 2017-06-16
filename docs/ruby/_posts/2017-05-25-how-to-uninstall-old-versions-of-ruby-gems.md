---
description: How to clean up old ruby gems
---

## Overview

Chances are that if you have been using Ruby for a while, your system
will be full of [gems](https://rubygems.org/) and more specifically,
**outdated gems**.

Every time you perform an update with <kbd>$ gem update</kbd> the
default behaviour is to install a new gem version **maintaining** the
older one.

> The update command does not remove the previous version. 
> 
> <footer class="blockquote-footer"> <cite>Gem update command Help</cite></footer>
{: class="blockquote"}

## Removing old unused gems

To remove older gems we use the `clean` command:

> The cleanup command removes old versions of gems from GEM_HOME that
> are not required to meet a dependency.  If a gem is installed
> elsewhere in GEM_PATH the cleanup command won't delete it.
>
> If no gems are named all gems in GEM_HOME are cleaned.
> 
> <footer class="blockquote-footer"> <cite>Gem cleanup command Help</cite></footer>
{: class="blockquote"}

We can choose to specify a gem to remove its older versions or remove
every old gem:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>gem cleanup</kbd>
Cleaning up installed gems...
Attempting to uninstall test-unit-3.1.7
Unable to uninstall test-unit-3.1.7:
        Gem::InstallError: test-unit is not installed in GEM_HOME, try:
        gem uninstall -i /usr/share/rubygems-integration/all test-unit
Attempting to uninstall public_suffix-2.0.4
Successfully uninstalled public_suffix-2.0.4
Attempting to uninstall power_assert-0.2.7
Unable to uninstall power_assert-0.2.7:
        Gem::InstallError: power_assert is not installed in GEM_HOME, try:
        gem uninstall -i /usr/share/rubygems-integration/all power_assert
Attempting to uninstall nokogiri-1.6.8.1
Successfully uninstalled nokogiri-1.6.8.1
Attempting to uninstall minitest-5.9.0
Unable to uninstall minitest-5.9.0:
        Gem::InstallError: minitest is not installed in GEM_HOME, try:
        gem uninstall -i /usr/share/rubygems-integration/all minitest
Attempting to uninstall rb-inotify-0.9.7
Successfully uninstalled rb-inotify-0.9.7
Attempting to uninstall kramdown-1.12.0
Successfully uninstalled kramdown-1.12.0
Attempting to uninstall jekyll-seo-tag-2.0.0
Successfully uninstalled jekyll-seo-tag-2.0.0
Attempting to uninstall jekyll-3.3.0
Successfully uninstalled jekyll-3.3.0
Attempting to uninstall jekyll-sass-converter-1.4.0
Successfully uninstalled jekyll-sass-converter-1.4.0
Attempting to uninstall sass-3.4.22
Successfully uninstalled sass-3.4.22
Attempting to uninstall kramdown-1.13.1
Successfully uninstalled kramdown-1.13.1
Attempting to uninstall html-proofer-3.3.1
Successfully uninstalled html-proofer-3.3.1
Attempting to uninstall parallel-1.9.0
Successfully uninstalled parallel-1.9.0
Attempting to uninstall nokogiri-1.7.0
Successfully uninstalled nokogiri-1.7.0
</samp>
</pre>

## References

- [Removing old versions of gems](https://stackoverflow.com/q/27933683/1165509)
  
