---
description: An overview of the javascript Angular framework basic concepts to get started.
---

This is a guide to understand Angular core concepts.

## Overview 

Angular is a Javascript framework to build *web* and *mobile*
applications.

It has a command line utility to facilitate tasks <kbd>ng</kbd>
installed with `npm install -g @angular/cli`.

## Basic Concepts

Angular is based in these concepts:

- Javascript classes
- Javascript modules
- **Dependency injection** defined by **TypeScript types**.
- **Metadata** defined by **decorators**.

*Typescript* is a superset of JavaScript that compiles to plain
Javascript, with the ability to add optional static typing to the
language.
{: .alert .alert-info}

### Javascript classes

Javascript
[classes](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes) are
used to 

1. create objects

	To define a class we can use one of two methods, both using
	prototype-based inheritance.

	A **class expression**:

		var MyClass = class [className] [extends] {
		  // class body
		};

	Or we can use a **class declaration**.
	
		class name [extends] {
		  // class body
		}

	The difference between them is that *class declaration* doesn't
    allow an existing class to be re-declared.
	
	Technically speaking, it is said that 
	
	> function declarations
	> are
	> [hoisted](https://developer.mozilla.org/en-US/docs/Glossary/Hoisting) and
	> class declarations are not
	{: .blockquote}

2. deal with inheritance

	Inheritance makes it possible to extend existing classes to create
    new ones.
	
	The `extends` keyword is used to create a subclass.
	
		class Cat extends Animal {
		}

### Javascript modules

Each module is a piece of code (variable and function declarations,
objects, etc) that is executed once it is loaded. Some of them can be marked to
be exported so other modules can import and use them.

To import them we use the `import` keyword and to expose them to other
modules the `export` keyword.

~~~ typescript
import defaultMember from "module-name";
import * as name from "module-name";
import { member } from "module-name";
import { member as alias } from   "module-name";
import { member1 , member2 } from "module-name";
import { member1 , member2 as alias2 , [...] } from "module-name";
import defaultMember, { member [ , [...] ] } from "module-name";
import defaultMember, * as name from "module-name";
import "module-name";
~~~

> Angular apps are modular and Angular has its own modularity system
> called NgModules
>
> Every Angular app has at least one NgModule class, the root module,
> conventionally named AppModule.
>
> JavaScript also has its own module system for managing collections
> of JavaScript objects. It's completely different and unrelated to
> the NgModule system.
> 
> <footer class="blockquote-footer"> <cite><a href="https://angular.io/guide/architecture">ngModules docs</a></cite></footer>
{: class="blockquote" cite="https://angular.io/guide/architecture"}

### Dependency injection

Dependency injection (DI) is an application design pattern. In this
coding pattern the class receives its dependencies from external
sources rather than creating them itself.

Angular comes with a **dependency injection framework** called
**injector** where
you
[register classes](https://angular.io/guide/dependency-injection#injectable),
and it figures out how to create them.

Every time you need a class instance, instead of using a Factory, you
ask the injector to get it for you.

``` typescript
let car = injector.get(Car);
```

### Metadata

Decorators support annotating or modifying a class declaration,
method, accessor, property, or parameter. They can be used in Angular
with TypeScript.

> Angular has many decorators that attach metadata to classes so that it
> knows what those classes mean and how they should work.
> 
> <footer class="blockquote-footer"> <cite><a href="https://angular.io/guide/architecture">Modules notes</a></cite></footer>
{: class="blockquote" cite="https://angular.io/guide/architecture"}

> Decorators use the form `@expression`, where *expression* must
> evaluate to a function that will be called at runtime with
> information about the decorated declaration.

[NgModule](https://angular.io/api/core/NgModule) is a decorator
function that takes a single metadata object whose properties describe
the module.

## Project Structure 

To analyze a typical Angular project structure we create a new one
with the command line app `ng`:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>ng new --help</kbd>
ng new < options... >
  Creates a new directory and a new Angular app eg. "ng new [name]".
  aliases: n
  --dry-run (Boolean) (Default: false) Run through without making any changes. Will list all files that would have been created when running "ng new".
    aliases: -d, --dryRun
  --verbose (Boolean) (Default: false) Adds more details to output logging.
    aliases: -v, --verbose
  --skip-install (Boolean) (Default: false) Skip installing packages.
    aliases: -si, --skipInstall
  --skip-git (Boolean) (Default: false) Skip initializing a git repository.
    aliases: -sg, --skipGit
  --skip-tests (Boolean) (Default: false) Skip creating spec files.
    aliases: -st, --skipTests
  --skip-commit (Boolean) (Default: false) Skip committing the first commit to git.
    aliases: -sc, --skipCommit
  --directory (String) The directory name to create the app in.
    aliases: -dir < value >, --directory < value >
  --source-dir (String) (Default: src) The name of the source directory. You can later change the value in ".angular-cli.json" (apps[0].root).
    aliases: -sd < value >, --sourceDir < value >
  --style (String) (Default: css) The style file default extension. Possible values: css, scss, less, sass, styl(stylus). You can later change the value in ".angular-cli.json" (defaults.styleExt).
    aliases: --style < value >
  --prefix (String) (Default: app) The prefix to use for all component selectors. You can later change the value in ".angular-cli.json" (apps[0].prefix).
    aliases: -p < value >, --prefix < value >
  --routing (Boolean) (Default: false) Generate a routing module.
    aliases: --routing
  --inline-style (Boolean) (Default: false) Should have an inline style.
    aliases: -is, --inlineStyle
  --inline-template (Boolean) (Default: false) Should have an inline template.
    aliases: -it, --inlineTemplate
  --minimal (Boolean) (Default: false) Should create a minimal app.
    aliases: --minimal
</samp>
</pre>

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>ng new my-app</kbd>
installing ng
  create .editorconfig
  create README.md
  create src/app/app.component.css
  create src/app/app.component.html
  create src/app/app.component.spec.ts
  create src/app/app.component.ts
  create src/app/app.module.ts
  create src/assets/.gitkeep
  create src/environments/environment.prod.ts
  create src/environments/environment.ts
  create src/favicon.ico
  create src/index.html
  create src/main.ts
  create src/polyfills.ts
  create src/styles.css
  create src/test.ts
  create src/tsconfig.app.json
  create src/tsconfig.spec.json
  create src/typings.d.ts
  create .angular-cli.json
  create e2e/app.e2e-spec.ts
  create e2e/app.po.ts
  create e2e/tsconfig.e2e.json
  create .gitignore
  create karma.conf.js
  create package.json
  create protractor.conf.js
  create tsconfig.json
  create tslint.json
You can `ng set --global packageManager=yarn`.
Installing packages for tooling via npm.
        Installed packages for tooling via npm.
Successfully initialized git.
Project 'my-app' successfully created.

</samp>
</pre>

### Tree

The project is arranged in the following way:

~~~
.
└── my-app
    ├── e2e                            # end-to-end tests
    │   ├── app.e2e-spec.ts
    │   ├── app.po.ts
    │   └── tsconfig.e2e.json
    ├── karma.conf.js                  # https://karma-runner.github.io/
    ├── .editorconfig                  # http://editorconfig.org
    ├── .angular-cli.json              # Configuration for Angular CLI
    ├── package.json                   # npm - third party packages
    ├── protractor.conf.js             # http://www.protractortest.org/#/
    ├── README.md
    ├── src
    │   ├── app
    │   │   ├── app.component.css
    │   │   ├── app.component.html
    │   │   ├── app.component.spec.ts
    │   │   ├── app.component.ts       # Defines AppComponent
    │   │   └── app.module.ts          # Defines AppModule
    │   ├── assets                     # Static files copied at build time
    │   ├── environments               # Configurations for each env
    │   │   ├── environment.prod.ts
    │   │   └── environment.ts
    │   ├── favicon.ico
    │   ├── index.html                 # Page served
    │   ├── main.ts                    # Main entry point of the app 
    │   ├── polyfills.ts
    │   ├── styles.css                 # Styles that affect all of your app
    │   ├── test.ts                    # Main entry point for unit tests
    │   ├── tsconfig.app.json          # TypeScript compiler config for app
    │   ├── tsconfig.spec.json         # TypeScript compiler config	for tests
    │   └── typings.d.ts
    ├── tsconfig.json
    └── tslint.json
~~~

## Files

As we see in this particular project structure, the project is full of
HTML and Typescript files (`.ts` extension).

Most relevant files goes inside `src` directory, while files outside
`src` folder are just meant to support building the app.

## Components

The typescript file located at `./src/app/app.component.ts` is a
special one called **root component** and its noted `app-root`.

**Components** control a section of the screen called **view**. They
can be a navigation bar, a list of items, etc.

Each component can have associated files to define its CSS styling and
HTML template.

A component contains the `AppComponent` class definition, like:

~~~ typescript
export class AppComponent {
  name = 'This is my component';
}
~~~

and a decorator with for example, data bindings to properties defined
in the class: 

~~~ typescript
@Component({
  selector: 'my-app',
  template: `<h1>Name: {{name}}</h1>`,
})
~~~

Double curly braces are the interpolation binding syntax used by
Angular.

Instead of a literal string as a property value in the Component, a
class can be used:

~~~ typescript
export class Description {
  name: string;
}

export class AppComponent  {
    description : Description = {
		name: 'Some desc'
    };
}
~~~

~~~ typescript
@Component({
  selector: 'my-app',
  template: `<h1>Name: {{description.name}}</h1>`,
})
~~~

~~~ typescript
~~~



## Modules

There is also a special file called **root module**. It tells
Angular
[how to assemble the application](https://angular.io/guide/bootstrapping) and
is located at ` app/app.module.ts`.

## Useful commands

Commands to work with and without the `ng` command line tool.

- Create a new project based on the QuickStart: <kbd>git clone https://github.com/angular/quickstart.git my-app</kbd>
- Install npm packages:  <kbd>npm install</kbd>
- Compile and serve: <kbd>npm start</kbd>
- Run the TypeScript compiler once: <kbd>npm run build</kbd>
- Run the TypeScript compiler in watch mode: <kbd>npm run
  build:w</kbd>
- Run a light-weight, static file server [lite-server](https://www.npmjs.com/package/lite-server) <kbd>npm run serve</kbd>
- Karma unit tests (compiles the application, simultaneously re-compiles and runs the karma test-runner): <kbd>npm test</kbd>
- Protractor e2e tests (compiles, starts the lite-server and launches Protractor): <kbd>npm run e2e</kbd>
  
## References

- <https://angular.io/guide/quickstart>
- <https://en.wikipedia.org/wiki/TypeScript>
- <https://www.typescriptlang.org/>
- <https://angular.io/guide/bootstrapping>
- <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes>
- <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import>
- <https://www.typescriptlang.org/docs/handbook/classes.html>
- <https://www.typescriptlang.org/docs/handbook/decorators.html>



