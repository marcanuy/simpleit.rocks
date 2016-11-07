#!/usr/bin/env bash
#
# This is a modified version of David Moody's script
# https://davidxmoody.com/host-any-static-site-with-github-pages/

set -e # halt script on error

echo 'Search site and print specific deprecation warnings...'
echo 'bundle exec jekyll hyde'
bundle exec jekyll hyde

read -rsp $'Build site: $ JEKYLL_ENV=production bundle exec jekyll build
\nPress any key to continue...\n' -n1 key

JEKYLL_ENV=production bundle exec jekyll build

read -rsp $'Check for broken links: $ bundle exec htmlproofer --disable-external _site
\nPress any key to continue...\n' -n1 key

bundle exec htmlproofer --disable-external ./_site

read -rsp $'Push repo to github: master and gh-pages branches
\nPress any key to continue...\n' -n1 key

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
