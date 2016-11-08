#!/usr/bin/env bash
set -ev # halt script on error

bundle exec jekyll build
bundle exec htmlproofer ./_site --disable-external
