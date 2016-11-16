#!/usr/bin/env bash
set -ev # halt script on error

bundle exec jekyll build
# bundle exec htmlproofer ./_site --disable-external
# temporary fix to use bootstrap 4.0.0-alpha.5
bundle exec htmlproofer ./_site --disable-external --file-ignore "/.+\/bower_components\/tether.+/"
