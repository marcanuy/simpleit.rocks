---
description: Getting started with React. Notes and main concepts to understand how it works and how to build a website.
---

## Overview

This is a guide to understand React framework to build web
applications. It explores its main concepts and common project
structure.

**React is a declarative JavaScript library for building user
interfaces.**

> **declarative programming** is a programming paradigm—a style of
> building the structure and elements of computer programs—that
> expresses the logic of a computation without describing its control
> flow. (Opposite: imperative programming)
> 
> <footer class="blockquote-footer"> <cite><a href="https://en.wikipedia.org/wiki/Declarative_programming">Wikipedia
Declarative Programming page</a></cite></footer>
{: class="blockquote" cite="https://en.wikipedia.org/wiki/Declarative_programming"}

## Concepts

### Components

*React* is based around a **React Components class**. Everything in
React is a *Component*, it is said that its architecture is
*Component-based*.

Each component 

1. takes in parameters, called **props** to customize it
when creating them, and

2. returns a hierarchy of **views** to display via the `render`
   method, which returns a **React element** (a lightweight
   description of what to render)

#### Elements

**React Elements** is what a **React Component** returns, describing what
should appear on the screen.

#### Props

**Props** are arbitrary inputs passed to **React Components**. 
They can be seen as object arguments that customize *components*.

~~~ jsx
this.props
~~~

#### State

**State** allows **React components** to change their output over time
in response to:

- user actions, 
- network responses, and
- anything else

without preventing **components** acting like **pure functions** with
respect to their props. [^1]

> A pure function doesn't depend on and doesn't modify the states of
> variables out of its scope. Concretely, that means a pure function
> always returns the same result given same parameters.
> 
> <footer class="blockquote-footer"> <cite><a href="www.nicoespeon.com/en/2015/01/pure-functions-javascript/">Pure functions in JavaScript</a></cite></footer>
{: class="blockquote" cite="www.nicoespeon.com/en/2015/01/pure-functions-javascript/"}

> React components can have state by setting `this.state` in the
> constructor.


### JSX

JSX produces React "elements".
{: .alert .alert-info}

JSX adds XML syntax to JavaScript, so it can be thought that its name
is a mix of **Javascript**+**XML**.

To make the rendering definition easier, we use JSX that allows us to
use react components in an XML-syntax style, e.g.:

The `<div />` syntax is transformed at build time to
`React.createElement('div')`, so writing the above tag is the same as
writing using [React.createElement](https://facebook.github.io/react/docs/react-api.html#createelement):

~~~ jsx
return React.createElement('div', {className: '...'},
  React.createElement('h1', ...),
  React.createElement('ul', ...)
);
~~~

> You can put any JavaScript expression within braces inside JSX. Each
> React element is a real JavaScript object that you can store in a
> variable or pass around your program.
> 
> <footer class="blockquote-footer"> <cite><a href="https://facebook.github.io/react/tutorial/tutorial.html">React tutorial</a></cite></footer>
{: class="blockquote" cite="https://facebook.github.io/react/tutorial/tutorial.html"}

## Recipes

### Passing data through Components

Using **props** when instantiating a component like `<MyComponent
value=somevalue />` then we can use it in another component accessing
`this.props` in *MyComponent*, e.g.:

~~~ jsx
class Board extends React.Component {
  render() {
    return <Square value={i} />;
  }
}

class Square extends React.Component {
  ...
  render() {
    return (
      <button className="square">
        {this.props.value}
      </button>
    );
  }
}
~~~

#### Aggregation of many components

> When you want to aggregate data from multiple children or to have
> two child components communicate with each other, move the state
> upwards so that it lives in the parent component. The parent can
> then pass the state back down to the children via props, so that the
> child components are always in sync with each other and with the
> parent.
> 
> Pulling state upwards like this is common when refactoring React components.
> <footer class="blockquote-footer"> <cite><a
href="https://facebook.github.io/react/tutorial/tutorial.html#passing-data-through-props">Passing
data through props</a></cite></footer>
{: class="blockquote" cite="https://facebook.github.io/react/tutorial/tutorial.html#passing-data-through-props"}

### Inmutability

There are two ways of changing data:

1. **mutation**
2. **replace with new copy**

In React it is better to create new versions of data instead of
directly modifying it, like instead of directly modifying an array
value, make a copy of it.

This has several advantages:

- better performance.
- easier to implement complex features (keeping older versions we can
  switch to them as needed).
- tracking changes is difficult, determining an immutable object
  change is trivial, this helps to determine when a component requires
  being re-rendered.

More at: <https://facebook.github.io/react/tutorial/tutorial.html#why-immutability-is-important>.

### Interactive Components

### Functional Components

Functional Components is a simpler syntax for component types **that only consist of a render method**.

Rather than defining a class extending `React.Component`, have a
function that takes `props` and returns what should be rendered.

~~~ jsx
function Mycomponent(props) {
  return (
    <button className="foobar">
      {props.value}
    </button>
  );
}
~~~

`this` won't be available, so `this.props` become `props`
{: .alert .alert-danger}

### History

## Useful commands

- Installation of `create-react` command line utility:

         npm install -g create-react-app
		 
### Create react app

This tool creates a fronted build pipeline without backend logic or
databases <kbd>create-react-app my-app</kbd>.

It makes available the commands `start`, `build`, `test` and `eject`:

- To start the app <kbd>npm start</kbd>, which will run `react-scripts start`.
- To deploy, first create an optimized build in the `build` folder with <kbd>npm run build</kbd>.

## References

- <https://facebook.github.io/react/docs/installation.html>
	

[^1]: https://facebook.github.io/react/docs/	
