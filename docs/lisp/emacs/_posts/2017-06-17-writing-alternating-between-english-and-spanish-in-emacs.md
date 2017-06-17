---
description: How to change the keyboard layout between English and Spanish quickly in Emacs to be able to write accents and other Spanish letters.
---

## Overview

If you write in Spanish and English then you will have to choose
between using a keyboard with Spanish or English layout. No matter
which one you select, when you write in the other language you will
have to choose a strategy to handle the letters that are present in
one language that are not in the other one.

This is a quick overview to handle this situation with an English
keyboard layout (i.e.: not having `ñ`, and tildes `ó`, `á`, etc)

## Changing the keyboard layout

In Emacs you can quickly change the layout with `set-input-method`,
which will change the keyboard layout for the current buffer.

> set-input-method:
>  Select and activate input method INPUT-METHOD for the current buffer.
>  This also sets the default input method to the one you specify.
> 
> <footer class="blockquote-footer">mule-cmds.el <cite>Emacs manual</cite></footer>
{: class="blockquote"}

There are three alternatives for **Spanish**:

1. spanish-keyboard
2. spanish-postfix
3. spanish-prefix

## Check layouts

What layout each keyboard uses? Let's find out with
<kbd>quail-show-keyboard-layout</kbd>, in each input method it prints
the recognized layout:

1. **spanish-keyboard**

~~~
Keyboard layout (keyboard type: standard)

     +----------------------------------------------------------------+
      | 1 ! | 2 " | 3 · | 4 $ | 5 % | 6 & | 7 / | 8 ( | 9 ) | 0 = | ' ? | ¡ ¿ | í Í |
     +----------------------------------------------------------------+
        | q Q | w W | e E | r R | t T | y Y | u U | i I | o O | p P | é É | ó Ó |
       +------------------------------------------------------------+
         | a A | s S | d D | f F | g G | h H | j J | k K | l L | ñ Ñ | á Á | ú Ú |
        +-----------------------------------------------------------+
           | z Z | x X | c C | v V | b B | n N | m M | , ; | . : | - _ |
          +-------------------------------------------------+
		    +-----------------------------+
		    |          space bar          |
		    +-----------------------------+
~~~

2. spanish-postfix

~~~
Keyboard layout (keyboard type: standard)

     +----------------------------------------------------------------+
      | 1 ! | 2 @ | 3 # | 4 $ | 5 % | 6 ^ | 7 & | 8 * | 9 ( | 0 ) | - _ | = + | ` ~ |
     +----------------------------------------------------------------+
        | q Q | w W | e E | r R | t T | y Y | u U | i I | o O | p P | [ { | ] } |
       +------------------------------------------------------------+
         | a A | s S | d D | f F | g G | h H | j J | k K | l L | ; : | ' " | \ | |
        +-----------------------------------------------------------+
           | z Z | x X | c C | v V | b B | n N | m M | , < | . > | / ? |
          +-------------------------------------------------+
		    +-----------------------------+
		    |          space bar          |
		    +-----------------------------+
~~~

3. spanish-prefix

~~~
Keyboard layout (keyboard type: standard)

     +----------------------------------------------------------------+
      | 1 ! | 2 @ | 3 # | 4 $ | 5 % | 6 ^ | 7 & | 8 * | 9 ( | 0 ) | - _ | = + | ` ~ |
     +----------------------------------------------------------------+
        | q Q | w W | e E | r R | t T | y Y | u U | i I | o O | p P | [ { | ] } |
       +------------------------------------------------------------+
         | a A | s S | d D | f F | g G | h H | j J | k K | l L | ; : | ' " | \ | |
        +-----------------------------------------------------------+
           | z Z | x X | c C | v V | b B | n N | m M | , < | . > | / ? |
          +-------------------------------------------------+
		    +-----------------------------+
		    |          space bar          |
		    +-----------------------------+

~~~

## Choosing the layout

- **spanish-keyboard**: while having all the typical Spanish letters
their own key, I don't find it pretty close to any other keyboard I
have ever tried.

- **spanish-postfix**: expects to press tildes **after** the desired
letter, for example `o+tilde=ó` which I find a bit unnatural.

- **spanish-prefix**: The one that resembles more the classical Spanish keyboard behaviour
is the **spanish-prefix** one. In this one you will write tildes
before the letter, e.g.: 

  - to write **ó**: press the tilde key and **then** the <kbd>o</kbd>.
  - to write **ñ**: press the <kbd>~</kbd> symbol and **then** <kbd>o</kbd>


## Conclusion

After executing <kbd>set-input-method</kbd> and selecting
**spanish-prefix**, writing in each language is as easy as switching
them with <kbd>C-\</kbd> *(toggle-input-method)* and have a pretty close experience as using a
Spanish keyboard in an English keyboard layout.

> toggle-input-method:
>
>   Enable or disable multilingual text input method for the current
>   buffer. Only one input method can be enabled at any time in a given buffer.
> 
> <footer class="blockquote-footer">mule-cmds.el <cite>Emacs manual</cite></footer>
{: class="blockquote"}

