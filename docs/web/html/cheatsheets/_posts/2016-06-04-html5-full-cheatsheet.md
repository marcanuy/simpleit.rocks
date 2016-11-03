---
title:
subtitle:
layout: post
tags:
- html
- cheatsheet
- html5
- quickreference
description: >
  Full HTML 5 cheatsheet. Quick reference for sections and elements <br>
  summary, with short explanations and usage examples.
---

## Overview

This is a table of all the elements of HTML 5, based in the summaries provided in the official [HTML 5 W3C Recommendation](https://www.w3.org/TR/html5/).

## HTML5 SECTIONS

Quick reference based in [HTML5 Sections](https://www.w3.org/TR/html5/sections.html)

### body ###

> The [body](https://www.w3.org/TR/html5/sections.html#the-body-element)
> element represents the content of the document.
{: cite="https://www.w3.org/TR/html5/sections.html#the-body-element"}

~~~ html
<!DOCTYPE HTML>
<html>
 <head> <title>Steve Hill's Home Page</title> </head>
 <body> <p>Hard Trance is My Life.</p> </body>
</html>
~~~

### article ###

> The [article](https://www.w3.org/TR/html5/sections.html#the-article-element)
> element represents a complete, or self-contained, composition in a
> document, page, application, or site and that is, in principle,
> independently distributable or reusable, e.g. in syndication.
{: cite="https://www.w3.org/TR/html5/sections.html#the-article-element"}

~~~ html
<article>
 <img src="/tumblr_masqy2s5yn1rzfqbpo1_500.jpg" alt="Yellow smiley face with the caption 'masif'">
 <p>My fave Masif tee so far!</p>
 <footer>Posted 2 days ago</footer>
</article>
<article>
 <img src="/tumblr_m9tf6wSr6W1rzfqbpo1_500.jpg" alt="">
 <p>Happy 2nd birthday Masif Saturdays!!!</p>
 <footer>Posted 3 weeks ago</footer>
</article>
~~~

### section ###

> The [section](https://www.w3.org/TR/html5/sections.html#the-section-element)
> element represents a generic section of a document or application.
> A section, in this context, is a thematic grouping of content. The theme
> of each section should be identified, typically by including a heading
> (h1-h6 element) as a child of the section element.
{: cite="https://www.w3.org/TR/html5/sections.html#the-section-element"}

~~~ html
<h1>Biography</h1>
<section>
 <h1>The facts</h1>
 <p>1500+ shows, 14+ countries</p>
</section>
<section>
 <h1>2010/2011 figures per year</h1>
 <p>100+ shows, 8+ countries</p>
</section>
~~~

### nav ###

> The [nav](https://www.w3.org/TR/html5/sections.html#the-nav-element)
> element represents a section of a page that links to other pages or to
> parts within the page: a section with navigation links.
{: cite="https://www.w3.org/TR/html5/sections.html#the-nav-element"}

~~~ html
<nav>
 <ul>
  <li><a href="/">Home</a>
  <li><a href="/biog.html">Bio</a>
  <li><a href="/discog.html">Discog</a>
 </ul>
</nav>
~~~

### aside  ###

> The [aside](https://www.w3.org/TR/html5/sections.html#the-aside-element)
> element represents a section of a page that consists of content that is
> tangentially related to the content around the aside element, and which
> could be considered separate from that content.
{: cite="https://www.w3.org/TR/html5/sections.html#the-aside-element"}

~~~ html
<h1>Music</h1>
<p>As any burner can tell you, the event has a lot of trance.</p>
<aside>You can buy the music we played at our <a href="buy.html">playlist page</a>.</aside>
<p>This year we played a kind of trance that originated in Belgium, Germany, and the Netherlands in the mid 90s.</p>
~~~

### h1–h6  A section heading ####

> These elements represent
> [headings](https://www.w3.org/TR/html5/sections.html#the-h1,-h2,-h3,-h4,-h5,-and-h6-elements)
> for their sections.
{: cite="https://www.w3.org/TR/html5/sections.html#the-h1,-h2,-h3,-h4,-h5,-and-h6-elements"}

~~~ html
<h1>The Guide To Music On The Playa</h1>
<h2>The Main Stage</h2>
<p>If you want to play on a stage, you should bring one.</p>
<h2>Amplified Music</h2>
<p>Amplifiers up to 300W or 90dB are welcome.</p>
~~~

### header ###

> The [header](https://www.w3.org/TR/html5/sections.html#the-header-element)
> element represents introductory content for its nearest ancestor
> sectioning content or sectioning root element. A header typically
> contains a group of introductory or navigational aids.
{: cite="https://www.w3.org/TR/html5/sections.html#the-header-element"}

~~~ html
<article>
 <header>
  <h1>Hard Trance is My Life</h1>
  <p>By DJ Steve Hill and Technikal</p>
 </header>
 <p>The album with the amusing punctuation has red artwork.</p>
</article>
~~~

### footer 	###

> The [footer](https://www.w3.org/TR/html5/sections.html#the-footer-element)
> element represents a footer for its nearest ancestor sectioning content
> or sectioning root element.
{: cite="https://www.w3.org/TR/html5/sections.html#the-footer-element"}

~~~ html
<article>
 <h1>Hard Trance is My Life</h1>
 <p>The album with the amusing punctuation has red artwork.</p>
 <footer>
  <p>Artists: DJ Steve Hill and Technikal</p>
 </footer>
</article>
~~~

## TEXT LEVEL SEMANTICS

Quick reference based in [HTML 5 text level semantics](https://www.w3.org/TR/html5/text-level-semantics.html).

| Element | Purpose | Example | Output |
|:--------|:-------:|--------:|-------:|
| __a__ | [Hyperlinks](https://www.w3.org/TR/html5/text-level-semantics.html#the-a-element) | `Visit my <a href="http://example.com">example</a> page.` | Visit my <a href="http://example.com">example</a> page. |
| __em__ | [Stress emphasis](https://www.w3.org/TR/html5/text-level-semantics.html#the-em-element) | `I must say I <em>adore</em> lemonade.` | I must say I <em>adore</em> lemonade. |
| __strong__ | [Importance](https://www.w3.org/TR/html5/text-level-semantics.html#the-strong-element) | `This tea is <strong>very hot</strong>.` | This tea is <strong>very hot</strong>. |
| __small__ | [Side comments](https://www.w3.org/TR/html5/text-level-semantics.html#the-small-element) | `These grapes are made into wine. <small>Alcohol is addictive.</small>` | These grapes are made into wine. <small>Alcohol is addictive.</small> |
| __s__ | [Inaccurate text](https://www.w3.org/TR/html5/text-level-semantics.html#the-s-element) | `Price: <s>£4.50</s> £2.00!` | Price: <s>£4.50</s> £2.00! |
| __cite__ | [Titles of works](https://www.w3.org/TR/html5/text-level-semantics.html#the-cite-element) | `The case <cite>Hugo v. Danielle</cite> is relevant here.` | The case <cite>Hugo v. Danielle</cite> is relevant here. |
| __q__ | [Quotations](https://www.w3.org/TR/html5/text-level-semantics.html#the-q-element) | `The judge said <q>You can drink water from the fish tank</q> but advised against it.` | The judge said <q>You can drink water from the fish tank</q> but advised against it. |
| __dfn__ | [Defining instance](https://www.w3.org/TR/html5/text-level-semantics.html#the-dfn-element) | `The term <dfn>organic food</dfn> refers to food produced without synthetic chemicals.` | The term <dfn>organic food</dfn> refers to food produced without synthetic chemicals. |
| __abbr__ | [Abbreviations](https://www.w3.org/TR/html5/text-level-semantics.html#the-abbr-element) | `Organic food in Ireland is certified by the <abbr title="Irish Organic Farmers and Growers Association">IOFGA</abbr>.` | Organic food in Ireland is certified by the <abbr title="Irish Organic Farmers and Growers Association">IOFGA</abbr>. |
| __data__ | [Machine-readable equivalent](https://www.w3.org/TR/html5/text-level-semantics.html#the-data-element) | `Available starting today! <data value="UPC:022014640201">North Coast Organic Apple Cider</data>` | Available starting today! <data value="UPC:022014640201">North Coast Organic Apple Cider</data> |
| __time__ | [Machine-readable equivalent of date- or time-related data](https://www.w3.org/TR/html5/text-level-semantics.html#the-time-element) | `Available starting on <time datetime="2011-11-12">November 12th</time>!` | Available starting on <time datetime="2011-11-12">November 12th</time>! |
| __code__ | [Computer code](https://www.w3.org/TR/html5/text-level-semantics.html#the-code-element) | `The <code>fruitdb</code> program can be used for tracking fruit production.` | The <code>fruitdb</code> program can be used for tracking fruit production. |
| __var__ | [Variables](https://www.w3.org/TR/html5/text-level-semantics.html#the-var-element) | `If there are <var>n</var> fruit in the bowl, at least <var>n</var>÷2 will be ripe.` | If there are <var>n</var> fruit in the bowl, at least <var>n</var>÷2 will be ripe. |
| __samp__ | [Computer output](https://www.w3.org/TR/html5/text-level-semantics.html#the-samp-element) | `The computer said <samp>Unknown error -3</samp>.` | The computer said <samp>Unknown error -3</samp>. |
| __kbd__ | [User input](https://www.w3.org/TR/html5/text-level-semantics.html#the-kbd-element) | `Hit <kbd>F1</kbd> to continue.` | Hit <kbd>F1</kbd> to continue. |
| __sub__ | [Subscripts](https://www.w3.org/TR/html5/text-level-semantics.html#the-sub-and-sup-elements) | `Water is H<sub>2</sub>O.` | Water is H<sub>2</sub>O. |
| __sup__ | [Superscripts](https://www.w3.org/TR/html5/text-level-semantics.html#the-sub-and-sup-elements) | `The Hydrogen in heavy water is usually <sup>2</sup>H.` | The Hydrogen in heavy water is usually <sup>2</sup>H. |
| __i__ | [Alternative voice](https://www.w3.org/TR/html5/text-level-semantics.html#the-i-element) | `Lemonade consists primarily of <i>Citrus limon</i>.` | Lemonade consists primarily of <i>Citrus limon</i>. |
| __b__ | [Keywords](https://www.w3.org/TR/html5/text-level-semantics.html#the-b-element) | `Take a <b>lemon</b> and squeeze it with a <b>juicer</b>.` | Take a <b>lemon</b> and squeeze it with a <b>juicer</b>. |
| __u__ | [Annotations](https://www.w3.org/TR/html5/text-level-semantics.html#the-u-element) | `The mixture of apple juice and <u class="spelling">eldeflower</u> juice is very pleasant.` | The mixture of apple juice and <u class="spelling">eldeflower</u> juice is very pleasant. |
| __mark__ | [Highlight](https://www.w3.org/TR/html5/text-level-semantics.html#the-mark-element) | `Elderflower cordial, with one <mark>part</mark> cordial to ten <mark>part</mark>s water, stands a<mark>part</mark> from the rest.` | Elderflower cordial, with one <mark>part</mark> cordial to ten <mark>part</mark>s water, stands a<mark>part</mark> from the rest. |
| __ruby , rb, rp, rt, rtc__ | [Ruby annotations](https://www.w3.org/TR/html5/text-level-semantics.html#the-ruby-element) | `<ruby> <rb>OJ <rp>(<rtc><rt>Orange Juice</rtc><rp>)</ruby>` | <ruby> <rb>OJ <rp>(<rtc><rt>Orange Juice</rtc><rp>)</ruby> |
| __bdi__ | [Text directionality isolation](https://www.w3.org/TR/html5/text-level-semantics.html#the-bdi-element) | `The recommended restaurant is <bdi lang="">My Juice Café (At The Beach)</bdi>.` | The recommended restaurant is <bdi lang="">My Juice Café (At The Beach)</bdi>. |
| __bdo__ | [Text directionality formatting](https://www.w3.org/TR/html5/text-level-semantics.html#the-bdo-element) | `The proposal is to write English, but in reverse order. "Juice" would become "<bdo dir=rtl>Juice</bdo>"` | The proposal is to write English, but in reverse order. "Juice" would become "<bdo dir=rtl>Juice</bdo>" |
| __span__ | [Other](https://www.w3.org/TR/html5/text-level-semantics.html#the-span-element) | `In French we call it <span lang="fr">sirop de sureau</span>.` | In French we call it <span lang="fr">sirop de sureau</span>. |
| __br__ | [Line break](https://www.w3.org/TR/html5/text-level-semantics.html#the-br-element) | `Simply Orange Juice Company<br>Apopka, FL 32703<br>U.S.A.` | Simply Orange Juice Company<br>Apopka, FL 32703<br>U.S.A. |
| __wbr__ | [Line breaking opportunity](https://www.w3.org/TR/html5/text-level-semantics.html#the-wbr-element) | `www.simply<wbr>orange<wbr>juice.com` | www.simply<wbr>orange<wbr>juice.com |
{: class="table"}

