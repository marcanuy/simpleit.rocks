#!/usr/bin/env bash
#
# This is a modified version of David Moody's script
# https://davidxmoody.com/host-any-static-site-with-github-pages/

set -ev # halt script on error

JEKYLL_ENV=production bundle exec jekyll build

git config user.name "Travis CI"
git config user.email "$COMMIT_AUTHOR_EMAIL"

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

# Get the deploy key by using Travis's stored variables to decrypt deploy_key.enc
# https://gist.github.com/domenic/ec8b0fc8ab45f39403dd
ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}
openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in deploy_key.enc -out deploy_key -d
chmod 600 deploy_key
eval `ssh-agent -s`
ssh-add deploy_key


# Push both branches to GitHub
#git push --all origin
git push origin gh-pages
