---
description: A list of common tasks to do after publishing a Website.
---

## Overview

I've created an amazing
website, [buyed a domain](http://www.namecheap.com/?aff=35306) and
purchased a [web hosting service](https://m.do.co/c/b54bbc9a3125),
what's next?

This is a check list of common resources I find useful to check to see
if they fit my website needs, like setting up a CDN, cache, several
optimizations, analytics, etc.

## Statistics

- Set up Google Analytics <http://www.google.com/analytics/>

## Performance

- Set up Google Search Console (former Webmaster Tools)
  - Add HTTPS, WWW and non-WWW versions and select the preferred one
  - Submit Sitemap.xml to Search Console

- Monitor website’s uptime
  - It can be set up with a custom monitoring tool like a
    free <https://github.com/phpservermon/phpservermon>
  - or using some tools provided by services like Cloudflare

- Google's PageSpeed
  Insights <https://developers.google.com/speed/docs/insights/>
  
  > Page Speed Insights measures the performance of a page for mobile
  > devices and desktop devices. It fetches the url twice, once with a
  > mobile user-agent, and once with a desktop-user agent. 
  > 
  > <footer class="blockquote-footer"> <cite><a href="https://developers.google.com/speed/docs/insights/">About PageSpeed Insights</a></cite></footer>
  {: class="blockquote" cite="https://developers.google.com/speed/docs/insights/"}

- Set up Cloudflare <https://www.cloudflare.com>
  - CDN
  - Enable HTTPS Page Rules
  - Static files compression and minification (especially CSS and JS)
  
## SEO

- Add your site’s name, logo, and social links
  - <https://developers.google.com/search/docs/data-types/sitename>
  - <https://developers.google.com/search/docs/data-types/logo>
  - <https://developers.google.com/search/docs/data-types/social-profile-links>
- Enable breadcrumbs <https://developers.google.com/search/docs/data-types/breadcrumbs>	
- Add a sitelinks searchbox <https://developers.google.com/search/docs/data-types/sitelinks-searchbox>
- Check for missing `description` meta tag in HTML `<head>` pages section.
- Validate HTML: <https://validator.w3.org/>
- Submit a [sitemap](http://sitemaps.org/) to Google Search Console
- Add [OpenGraph](http://ogp.me/)
  and [Twitter cards](https://dev.twitter.com/cards/)
- Generate an [AMP](https://www.ampproject.org/docs/guides) version of the website

