# Using make (instead of rake) because:
# - does not depend on Ruby
# - tracks when files change
# - provides a standard interface between projects

SHELL := /bin/bash
LANG=en_US.UTF-8
LANGUAGE=en_US.UTF-8
LC_ALL=en_US.UTF-8
BUNDLE := bundle
YARN := yarn

JEKYLL := $(BUNDLE) exec jekyll
HTMLPROOF := $(BUNDLE) exec htmlproofer
DOMAIN = simpleit.rocks
ASSETS_DIR = assets
VENDOR_DIR = $(ASSETS_DIR)/vendor/

TEMPFILE := $(shell mktemp)

.PHONY: all clean install update

all : serve

check:
	$(JEKYLL) doctor
	$(HTMLPROOF) --check-html \
		--http-status-ignore 999 \
		--internal-domains $(DOMAIN),localhost:4000 \
		--assume-extension \
		--disable-external \
		_site

########################
# PROJECT DEPENDENCIES #
########################

PROJECT_DEPS := Gemfile package.json

install: $(PROJECT_DEPS)
	$(BUNDLE) install --path vendor/bundler
	$(YARN) install

update: $(PROJECT_DEPS)
	$(BUNDLE) update
	$(YARN) upgrade

#########
# SERVE #
#########

include-yarn-deps:
	mkdir -p $(VENDOR_DIR)
	cp node_modules/mermaid/dist/mermaid.forest.css $(VENDOR_DIR)
	cp node_modules/mermaid/dist/mermaid.min.js $(VENDOR_DIR)
	cp node_modules/font-awesome/css/font-awesome.min.css $(VENDOR_DIR)
	cp -r node_modules/font-awesome/fonts $(ASSETS_DIR)
	cp node_modules/jquery/dist/jquery.min.js $(VENDOR_DIR)
	cp node_modules/tether/dist/js/tether.min.js $(VENDOR_DIR)
	cp node_modules/bootstrap/dist/js/bootstrap.min.js $(VENDOR_DIR)
build: clean install include-yarn-deps
	$(JEKYLL) build
build-production: clean install include-yarn-deps
	JEKYLL_ENV=production $(JEKYLL) build
serve: clean install include-yarn-deps
	$(JEKYLL) serve --drafts
serve-limit: clean install include-yarn-deps
	$(JEKYLL) serve --limit_posts 1

serve-production: clean install include-yarn-deps
	JEKYLL_ENV=production $(JEKYLL) serve
deploy: build-production check
	echo "Push to github!"
clean :
	rm -fr _site/
	rm -fr $(VENDOR_DIR)
	rm -fr $(ASSETS_DIR)/fonts # fontawesome
	rm -fr .sass_cache
