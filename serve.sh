#!/bin/bash

firefox localhost:4000 &
emacs --maximized --eval "(progn (load-theme 'adwaita) (find-file '"~/Development/simpleit.rocks"))" &
bundle exec jekyll serve --drafts;

