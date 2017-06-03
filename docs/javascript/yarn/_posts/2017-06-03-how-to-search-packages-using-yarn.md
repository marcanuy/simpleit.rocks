---
description: Search packages with Yarn package manager. Get a list of tabular results.
---

## Overview

How to have the *search* functionailty like `npm search` or `bower
search` in Yarn, or simply look for packages in a browser.


## Options

### CLI search

Search yarn packages in command line using [npms-cli](https://github.com/npms-io/npms-cli):

Install `npms-cli`:

    yarn global add npms-cli

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>yarn global add npms-cli</kbd>
yarn global v0.24.5
[1/4] Resolving packages...
[2/4] Fetching packages...
[3/4] Linking dependencies...
[4/4] Building fresh packages...
success Installed "npms-cli@1.6.0" with binaries:
      - npms
Done in 14.05s.
</samp>
</pre>

Then you will have available `/usr/bin/npms` and can search like:
`npms search <desired package>`, for example for the package `font-awesome`:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>npms search font-awesome</kbd>
┌─────────────────────────────────────────────────────────────────────────────┬─────────┬────────────┬─────────────┬───────┐
│ Package                                                                     │ Quality │ Popularity │ Maintenance │ Score │
├─────────────────────────────────────────────────────────────────────────────┼─────────┼────────────┼─────────────┼───────┤
│ font-awesome • https://github.com/FortAwesome/Font-Awesome                  │         │            │             │       │
│ The iconic font and CSS framework                                           │   83    │     71     │     38      │  63   │
│ updated 7 months ago by juliankrispel                                       │         │            │             │       │
├─────────────────────────────────────────────────────────────────────────────┼─────────┼────────────┼─────────────┼───────┤
│ ember-font-awesome • https://github.com/martndemus/ember-font-awesome       │         │            │             │       │
│ An ember-cli addon for using Font Awesome icons in Ember applications.      │   89    │     22     │     100     │  70   │
│ updated 2 months ago by martndemus                                          │         │            │             │       │
├─────────────────────────────────────────────────────────────────────────────┼─────────┼────────────┼─────────────┼───────┤
│ font-awesome-filetypes • https://github.com/spatie/font-awesome-filetypes   │         │            │             │       │
│ Helper to retrieve the Font Awesome icon for a specific file extension      │   95    │     9      │     100     │  67   │
│ updated 2 years ago by sebastiandedeyne                                     │         │            │             │       │
├─────────────────────────────────────────────────────────────────────────────┼─────────┼────────────┼─────────────┼───────┤
....
└─────────────────────────────────────────────────────────────────────────────┴─────────┴────────────┴─────────────┴───────┘
</samp>
</pre>


### Search with browser

You can also search them using `https://npms.io/search?q=<desired
package>`:

<form action="https://npms.io/search" method="get" target="_blank">
  <div class="form-group">
    <label for="packageSearch">Package Search</label>
    <input type="text" class="form-control" id="q"
  aria-describedby="packageSearch" placeholder="Enter package name" name="q">
  </div>
  <button type="submit" class="btn btn-primary">Search</button>
</form>
