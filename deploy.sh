#!/bin/bash

# any command that fails will cause the script to abort.
set -e

echo 'Checking for errors...'
bundle exec jekyll hyde

read -rsp $'Will execute: JEKYLL_ENV=production bundle exec jekyll build
\nPress any key to continue...\n' -n1 key

JEKYLL_ENV=production bundle exec jekyll build

# Check for uncommitted changes or untracked files
####[ -n "$(git status --porcelain)" ] && git status && exit 1

# Switch to master branch without changing any files
git symbolic-ref HEAD refs/heads/gh-pages
git reset

# Add all changes in the build dir
git --work-tree=_site add -A
git --work-tree=_site commit -m "Published changes"

# Switch back to source
git symbolic-ref HEAD refs/heads/master
git reset

# Push both branches to GitHub
git push --all origin
