---
title: #If title is omitted, Jekyll generates a title based in the slug/filename
subtitle: Using Travis Continuous Integration
layout: post
description: > # Under 140 char. Used for meta description and main description
tags:
- git
- github
- gh-pages
- jekyll
- travis
---

{% comment %} main content {% endcomment %}
## Overview

A step-by-step guide to publish a Jekyll website automatically after
doing a `git push` to Github.

This guide makes use of *Github Pages*, *Jekyll* and *Travis CI*.

Github offers a free service called [Github Pages] to host regular
HTML content hosted directly from users GitHub repositories.

It has a special, built-in support, for Jekyll, one of the most popular static
site generators, but you will have to use the Jekyll version currently
supported by Github (not always the latest one) and it does not allow
custom Jekyll plugins, because Jekyll is executed with the `--safe` flag.

> GitHub Pages is powered by Jekyll. However, all Pages sites are
> generated using the --safe option to disable custom plugins for
> security reasons. Unfortunately, this means your plugins won’t work
> if you’re deploying to GitHub Pages.
>
> You can still use GitHub Pages to publish your site, but you’ll need
> to convert the site locally and push the generated static files to
> your GitHub repository instead of the Jekyll source files. 
> <footer class="blockquote-footer"><cite><a href="https://jekyllrb.com/docs/plugins/">Plugins on GitHub Pages</a></cite></footer>
{: class="blockquote" cite="https://jekyllrb.com/docs/plugins/"}

A simple way to overcome these limitations is to manually build the
site before pushing to the repo or make use of automation tools like
Travis CI that will do this job for us in each _push_ to Github.

## Steps

### Create the basic .travis.yml file

Travis configuration is stored in `.travis.yml`, we will create a new
one with the following contents (adjust versions to your needs):

~~~ yml
language: ruby
rvm:
- 2.3.1
before_script:
- npm install -g bower
- bower install
- chmod +x ./deploy.sh
script: bash ./deploy.sh
env:
  global:
  - NOKOGIRI_USE_SYSTEM_LIBRARIES=true
  - COMMIT_AUTHOR_EMAIL: me@marcanuy.com
sudo: false
~~~

### Create the deployment script deploy.sh

We will create the following `deploy.sh` script:

~~~ bash
#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

SOURCE_BRANCH="master"
TARGET_BRANCH="gh-pages"

function doCompile {
    JEKYLL_ENV=production bundle exec jekyll build -d out/
}

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    echo "Skipping deploy; just doing a build."
    doCompile
    exit 0
fi

# Save some useful information
REPO=`git config remote.origin.url`
SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}
SHA=`git rev-parse --verify HEAD`

# Clone the existing gh-pages for this repo into out/
# Create a new empty branch if gh-pages doesn't exist yet (should only happen on first deply)
git clone $REPO out
cd out
git checkout $TARGET_BRANCH || git checkout --orphan $TARGET_BRANCH
cd ..

# Clean out existing contents
rm -rf out/**/* || exit 0

# Run our compile script
doCompile

# Now let's go have some fun with the cloned repo
cd out
git config user.name "Travis CI"
git config user.email "$COMMIT_AUTHOR_EMAIL"

# If there are no changes to the compiled out (e.g. this is a README update) then just bail.
if [ -z `git diff --exit-code` ]; then
    echo "No changes to the output on this push; exiting."
    exit 0
fi

# Commit the "changes", i.e. the new version.
# The delta will show diffs between new and old versions.
git add .
git commit -m "Deploy to GitHub Pages: ${SHA}"

# Get the deploy key by using Travis's stored variables to decrypt deploy_key.enc
ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}
openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in deploy_key.enc -out deploy_key -d
chmod 600 deploy_key
eval `ssh-agent -s`
ssh-add deploy_key

# Now that we're all set up, we can push.
git push $SSH_REPO $TARGET_BRANCH
~~~

The script basically performs the following actions:

1. Create the _gh-pages_ branch `git checkout --orphan gh-pages`

> Updates files in the working tree to match the version in the index
> or the specified tree. If no paths are given, git checkout will also
> update HEAD to set the specified branch as the current branch.
> <footer class="blockquote-footer"> git checkout orphan flag in <cite><a href="https://git-scm.com/docs/git-checkout">git-checkout</a></cite></footer>
{: class="blockquote" cite="https://git-scm.com/docs/git-checkout"}

2. Generate the Jekyll build inside `out/` directory
3. Commit and deploy generated files to `gh-pages` branch

### Enable Travis for the repository

Sign in to Travis CI with your GitHub account.

Once you’re signed in, Travis will synchronize your repositories from
GitHub. Go to your profile page and enable Travis CI for the
repository you want to build.

### Generate credentials

We need to generate credentials to be able to publish the `gh-pages`
branch contents on GitHub
using
[Travis Automated Encryption](https://docs.travis-ci.com/user/encrypting-files/).

#### Generating a new SSH key to use with Travis

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>ssh-keygen -t rsa -b 4096 -C "your_github_email@example.com"</kbd>
Generating public/private rsa key pair.
Enter file in which to save the key (/home/marcanuy/.ssh/id_rsa): <kbd>deploy_key</kbd>
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in deploy_key.
Your public key has been saved in deploy_key.pub.
The key fingerprint is:
SHA256:vn3O/NkfKHg2nb9p0J7yam72elUInAHa0MtGWbsZ048 me@marcanuy.com
The key's randomart image is:
+---[RSA 4096]----+
|        .o.=o+   |
|        .o=.* .  |
|       oo+o.oo.+ |
|       o+ o  oE o|
|       .S ooo o .|
|          .  o..o|
|           o o++o|
|            o=-*=|
|            =*xX*|
+----[SHA256]-----+
</samp>
</pre>

### Add deploy key to GitHub keys

Add the generated **public key**: `deploy_key.pub` to your repository at
`https://github.com/<your name>/<your repo>/settings/keys`.

You can copy easily with `xclip` and then paste it in the keys textbox:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>xclip -sel clip < deploy_key.pub</kbd>
</samp>
</pre>

<img class="img-fluid" alt="Responsive image" src="/assets/travis_add_deploy_key.png">

Detailed steps are [in this Github guide](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/).

### Encrypt the generated deploy key with the Travis client

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>travis encrypt-file deploy_key --add</kbd>
Detected repository as marcanuy/simpleit.rocks, is this correct? |yes| <kbd>yes</kbd>
encrypting deploy_key for marcanuy/emacside.com
storing result as deploy_key.enc
storing secure env variables for decryption

Make sure to add deploy_key.enc to the git repository.
Make sure not to add deploy_key to the git repository.
Commit all changes to your .travis.yml.
</samp>
</pre>

### Edit .travis.yml with encryption ids

The previous step added the before_install section with the proper
command to decrypt the `deploy_key`, now we have to detect the
encription id and add an environment variable like: ` ENCRYPTION_LABEL: "<.... encryption label from previous step ....>"`

The encription id is the string between `$encrypted_` and `_key` in
the automatically added `before_install` line: 

<p>
openssl aes-256-cbc -K $encrypted_<span style="color:red">0c6d27255ccf</span>_key -iv $encrypted_0c6d27255ccf_iv -in deploy_key.enc -out deploy_key -d.
</p>

In the previous case I will have to add the line `- ENCRYPTION_LABEL:
0c6d27255ccf`, the file `.travis.yml` will look like:

~~~ yml
env:
  global:
  - ENCRYPTION_LABEL: 0c6d27255ccf
~~~

So the final `.travis.yml` is:

~~~ yml
language: ruby
rvm:
- 2.3.1
before_script:
- npm install -g bower
- bower install
- chmod +x ./deploy.sh
script: ./deploy.sh
env:
  global:
  - NOKOGIRI_USE_SYSTEM_LIBRARIES=true
  - COMMIT_AUTHOR_EMAIL: me@marcanuy.com
  - ENCRYPTION_LABEL: 0c6d27255ccf
sudo: false
before_install:
- openssl aes-256-cbc -K $encrypted_0c6d27255ccf_key -iv $encrypted_0c6d27255ccf_iv -in deploy_key.enc -out deploy_key -d
~~~

### Add deploy key to gitignore:

In `.gitignore` add *deploy_key*:

~~~
_site
.sass-cache
.jekyll-metadata
bower_components
deploy_key
deploy_key.pub
~~~

### Adding the travis button to github readme

In your project `README` file you can add the fancy Travis button with
the current status of the building, adding a similar code:

~~~
[![Build Status](https://travis-ci.org/marcanuy/emacside.com.svg?branch=master)](https://travis-ci.org/marcanuy/emacside.com)
~~~

You can find your project button url following [this guide](https://docs.travis-ci.com/user/status-images/).

## References

This guide is heavily based in [Auto-deploying built products to gh-pages with
  Travis](https://gist.github.com/domenic/ec8b0fc8ab45f39403dd)
  
Related articles:

- <https://docs.travis-ci.com/user/encrypting-files/>
- <https://github.com/settings/keys>
- <https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/#generating-a-new-ssh-key>
- <https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/>
- <http://awestruct.org/auto-deploy-to-github-pages/>
- <https://jekyllrb.com/docs/deployment-methods/>
- <https://jekyllrb.com/docs/continuous-integration/>

*[HTML]: HyperTextMarkupLanguage

[Github Pages]: https://pages.github.com
[Jekyll]: /docs/ruby/jekyll/
[Travis CI]: http://travis-ci.org/
