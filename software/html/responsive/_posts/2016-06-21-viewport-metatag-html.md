---
title: HTML viewport meta tag for responsive designs
subtitle: Mobile optimization
description: Viewport meta tag for Responsive Hiper Text Markup Language designs
layout: post
---

# Using the viewport meta tag

> A viewport controls how a webpage is displayed on a mobile device. Without a viewport, mobile devices will render the page at a typical desktop screen width, scaled to fit the screen. Setting a viewport gives control over the page's width and scaling on different devices.
>  Pages optimized to display well on mobile devices should include a meta viewport in the head of the document specifying width=device-width, initial-scale=1. 
{: cite="https://developers.google.com/speed/docs/insights/ConfigureViewport#overview"}
 
~~~ html
<meta name="viewport" content="width=device-width, initial-scale=1">
~~~

_CSS Media queries_ can be applied based on viewport size. Based on the characteristics of the device rendering the content, such as _width_ and _height_, media queries can change the styles used for each device characteristic.

> Use min-width over min-device-width to ensure the broadest experience.
> Use relative sizes for elements to avoid breaking layout.
{: cite="https://developers.google.com/web/fundamentals/design-and-ui/responsive/fundamentals/use-media-queries?hl=en"}

~~~ css
@media (query) {
  /* CSS Rules used when query matches */
}
~~~

+ <https://developer.mozilla.org/en/docs/Mozilla/Mobile/Viewport_meta_tag>
+ <https://developers.google.com/speed/docs/insights/ConfigureViewport>
+ <https://www.w3.org/TR/mwabp/#bp-viewport>
+ <http://www.w3schools.com/css/css_rwd_viewport.asp>
+ <https://developers.google.com/web/fundamentals/design-and-ui/responsive/fundamentals/use-media-queries?hl=en>
