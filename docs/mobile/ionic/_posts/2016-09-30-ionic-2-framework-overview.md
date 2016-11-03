---
title: 
layout: post
---

# Overview

Ionic 2 framework has been __designed to build cross-platform mobile apps__ and
web apps in a way similar to building websites, i.e.: using HTML, CSS, and
JavaScript ([Angular](https://angular.io/)) languages.

It is built on top of [Cordova](https://cordova.apache.org/), a framework 
to build mobile apps with HTML, CSS & JS. 

# Getting Started

## Installing

To use Ionic 2 installing Cordova is required: `$ sudo npm install -g cordova`

Then install Ionic: `$ npm install -g ionic@beta`

Start an [Ionic project](https://github.com/driftyco/ionic2-app-base)
with the ionic_[tutorial template](https://github.com/driftyco/ionic2-starter-tutorial)_:
`$ ionic start myProject tutorial --v2`

Then, to run it, enter project directory and _run_:

~~~
$ cd myProject
$ ionic platform add android
$ ionic run android
~~~

or serve it with:

~~~
$ ionic serve
~~~

## Directory structure

The basic structure of the app contains the following directories and files:

<pre>
config.xml
ionic.config.json
package.json       __the npm packages that will be in node_modules dir__
resources/         __platform specific resources__
tsconfig.json
tslint.json
hooks/
node_modules/
platforms/         __platform specific files e.g. for android or ios __
plugins/           __where cordova plugins are stored when installed__
src/               __our app source code__
tsconfig.tmp.json
www/
</pre>

The generated website will be in the `www` directory with a 
structure similar to:

<pre>
www/
├── assets
│   ├── fonts
│   │   ├── ionicons.eot
│   │   ├── ionicons.svg
│   │   ├── ionicons.ttf
│   │   ├── ionicons.woff
│   │   └── ionicons.woff2
│   ├── icon
│   │   └── favicon.ico
│   └── manifest.json
├── build
│   ├── main.css
│   ├── main.js
│   ├── main.js.map
│   └── polyfills.js
└── index.html       <-- root component of the app
</pre>

# App organization

## Pages

Each page of the application can be generated with `ionic generate page mylist`

And will contain [components](https://ionicframework.com/docs/v2/components/)
like `ionic-navbar` that will help to quickly create app interfaces.

# References

+ <http://ionicframework.com/docs/v2/>
