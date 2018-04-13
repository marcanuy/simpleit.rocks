---
description: A list of common tasks to do after publishing a Website.
---

## Overview

I've created an amazing
website, [buyed a domain](http://www.namecheap.com/?aff=35306) and
purchased a [web hosting service](https://m.do.co/c/b54bbc9a3125),
what's next?

This is a check list of common resources I am constantly needing after
(or before) launching a website, like setting up a CDN, cache, several
optimizations, analytics, etc.

Check them up to review your website needs.

## Statistics

- Set up Google Analytics <https://analytics.google.com/analytics/web>

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

## Monetization

- Add automatic ads (Google adsense - page level ads): 
  - <https://support.google.com/adsense/answer/7477845?hl=en>
  - <https://www.google.com/adsense/>
  
## SEO

- Add your site’s name, logo, and social links
  - <https://developers.google.com/search/docs/data-types/sitename>
  - <https://developers.google.com/search/docs/data-types/logo>
  - <https://developers.google.com/search/docs/data-types/social-profile-links>
- Enable breadcrumbs <https://developers.google.com/search/docs/data-types/breadcrumbs>	
- Add a sitelinks searchbox <https://developers.google.com/search/docs/data-types/sitelinks-searchbox>
- Check for missing `description` meta tag in HTML `<head>` pages section.
- Validate HTML: <https://validator.w3.org/>
- Add [OpenGraph](http://ogp.me/)
  and [Twitter cards](https://dev.twitter.com/cards/)
- Generate an [AMP](https://www.ampproject.org/docs/guides) version of the website

### Search Engines

#### Webmaster tools

Register each search engine webmaster tool:

- Google: <https://search.google.com/search-console/index>
  - One for the `www` domain and other for `non-www`, then select
    preferred one in admin's **Site Settings**.
- Bing: 
  - <https://www.bing.com/toolbox/submit-site-url>
  - <https://www.bing.com/toolbox/webmaster>
- Yandex: <https://webmaster.yandex.com/sites/add/>

#### Submit URLs

- Google: <https://www.google.com/webmasters/tools/submit-url>
- Bing: <https://www.bing.com/toolbox/submit-site-url>
- Yandex: <https://webmaster.yandex.com/site/indexing/reindex/>


## Sitemaps

- Include sitemaps in [robots.txt](https://developers.google.com/webmasters/control-crawl-index/docs/robots_txt) file using a `sitemap: [absoluteURL]` directive.

Supported by Google, Ask, Bing, Yahoo; defined on <http://sitemaps.org>.
{: .alert .alert-info}
 
- Submit a [sitemap](http://sitemaps.org/) to 
  - Google Search
    Console <https://www.google.com/webmasters/tools/sitemap-list>
  - Bing (and Yahoo!) 
  - Yandex <https://webmaster.yandex.com/site/*/indexing/sitemap/>
  
## HTML

- Add [Favicons](https://en.wikipedia.org/wiki/Favicon) for different platforms.
