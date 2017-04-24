---
title: Redirect HTTP to HTTPS and WWW to non-WWW with AWS S3, Cloudfront and Route 53 with a custom domain
description: Guide to host a website in Amazon S3 bucket using SSL and a custom non-www domain with Cloudfront CDN.
---

## Overview

This guide explains how to have a custom domain with a secure
connections, using Amazon services only.

After finishing the guide you will have the following:

- a static website hosted in Amazon [S3]
- [HTTPS] enabled
- all your requests redirects to the non-WWW version
  `https://example.com` 
- using Cloudfront [CDN].
- using Route 53, Amazon's domain name server manager

## Set up S3

S3 allows you to store and retrieve any amount of data, in particular
it makes it easy to set up static websites. The data hosted in S3 is
saved as *objects* and each object can have its custom permissions.

### Set up buckets

To have our website hosted in S3, we need to configure two buckets
in <https://console.aws.amazon.com/s3/buckets/>:

#### non-WWW bucket

One bucket for the naked domain called: `example.com`. This bucket will hold
our static website files.

Turn on the Static Website Hosting for `example.com`. 

Adjust permissions to allow reading your objects, go to the bucket
`Permissions` tab, and then `Bucket Policy`. We need to configure the
*Action*: **s3:GetObject**, then if you don't use the generator, it
will look something like:

~~~
{
    "Version": "2012-10-17",
    "Id": "Policy1492008478664",
    "Statement": [
        {
            "Sid": "Stmt1492008213599",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::example.com/*"
        }
    ]
}
~~~

#### WWW bucket

Another bucket for the www-version domain called: `www.example.com`. This
bucket will redirect all the requests that start with ***WWW*** to the
non WWW version.

Turn on the Static Website Hosting for `www.example.com`. 

Go to `Properties` tabs, `Static Website Hosting` and select
**Redirect requests** with the following values:

Target bucket or domain
: example.com

Protocol
: https

### Set up CDN

We need a CloudFront Distribution for each S3 bucket, so each website
will have its own [CDN].

Go to <https://console.aws.amazon.com/cloudfront/> and create two
**distributions** with just the default settings but with small
changes.

#### CDN for example.com

The `origin` setting should contain the custom URL endpoint of our S3
website, **avoid selecting the one that the dropdown list suggests for
us** (REST endpoint) as we need the *web site endpoint*, not the
bucket, it should have the following form:
`<bucket-name>.s3-website-<region>.amazonaws.com`, in this case:

Origin
: `example.com.s3-website-us-east-1.amazonaws.com`

Default Cache Behavior Settings / Viewer Protocol Policy
: Redirect HTTP to HTTPS

Distribution Settings / Alternate Domain Names (CNAMEs)
: example.com

Do **not** set the `Default Root Object` property.
{: .alert .alert-info }

Distribution Settings / SSL Certificate:
: Custom SSL Certificate (example.com) 
: Request or Import a Certificate with ACM

When you create the Certificate **include both domains** as we are
going to use this in the other distribution also:

Add domain names
: example.com
: www.example.com

And follow the instructions to validate the certificate, then make
sure it is selected in the *Distribution*.

Leave all other setting with their default value.

#### CDN for www.example.com

Create another distribution for the `www.example.com` domain with
these values:

Origin
: `www.example.com.s3-website-us-east-1.amazonaws.com`

Default Cache Behavior Settings / Viewer Protocol Policy
: Redirect HTTP to HTTPS

Distribution Settings / Alternate Domain Names (CNAMEs)
: www.example.com

Distribution Settings / SSL Certificate:
: Custom SSL Certificate (example.com) 
: Select our previously created certificate that includes this domain

### Set up domains

We are almost there, now it is time to configure the [DNS] registry
with [Route 53](https://console.aws.amazon.com/route53/home).

Go to **DNS management** / **Hosted Zones** and create a hosted zone
`example.com.`:

Domain Name:
- **example.com.**

Create a **Record Set** with these values: 

Name:
: <leave it empty>

Type:
: Alias: Yes
: Select the CloudFront distribution corresponding to `example.com`

Then create another **Record Set** for `www.example.com`:

Name:
: **www**

Type:
: Alias: Yes
: Select the CloudFront distribution corresponding to `www.example.com`

## Verification

Now wait the changes propagate, and then verify it is all working as
expected for HTTP, HTTPS and WWW, non-WWW URLs:

<pre class="shell">
<samp>
<span class="shell-prompt">$</span> <kbd>curl -sI http://example.com | grep -E '(301|Server|Location|X-Cache|HTTP)'</kbd>
HTTP/1.1 301 Moved Permanently
Server: CloudFront
Location: https://example.com/
X-Cache: Redirect from cloudfront
<span class="shell-prompt">$</span> <kbd>curl -sI https://example.com | grep -E '(X-Cache|HTTP)'</kbd>
HTTP/1.1 200 OK
X-Cache: Hit from cloudfront
<span class="shell-prompt">$</span> <kbd>curl -sI http://www.example.com | grep -E '(301|Server|Location|X-Cache|HTTP)'</kbd>
HTTP/1.1 301 Moved Permanently
Server: CloudFront
Location: https://www.example.com/
X-Cache: Redirect from cloudfront
<span class="shell-prompt">$</span> <kbd>curl -sI https://www.example.com | grep -E '(301|Server|Location|HTTP)'</kbd>
HTTP/1.1 301 Moved Permanently
Location: https://example.com/
Server: AmazonS3
</samp>
</pre>

Explanation of commands:

<dl class="row">
  <dt class="col-sm-3"><kbd>curl</kbd></dt>
  <dd class="col-sm-9"><blockquote>curl - transfer a URL</blockquote></dd>

  <dt class="col-sm-3"><kbd>curl -s</kbd></dt>
  <dd class="col-sm-9">Silent  or  quiet mode. Don't show progress meter or error messages.</dd>

  <dt class="col-sm-3"><kbd>curl -I</kbd></dt>
  <dd class="col-sm-9">(HTTP/FTP/FILE) Fetch the HTTP-header only</dd>

  <dt class="col-sm-3"><kbd>grep</kbd></dt>
  <dd class="col-sm-9"><blockquote>print lines matching a pattern</blockquote></dd>

  <dt class="col-sm-3"><kbd>grep -E, --extended-regexp</kbd></dt>
  <dd class="col-sm-9">Interpret PATTERN as an extended regular expression (ERE, see below).</dd>
</dl>

## Conclusion

Now all the requests to `example.com` will be served by
`https://example.com`.

## References

- S3 docs <https://aws.amazon.com/s3/>
- Cloudfront docs <https://aws.amazon.com/cloudfront/>
- Route 53 <https://aws.amazon.com/route53/>
- [RKI](http://stackoverflow.com/users/796468/rki) answer in [Cloudfront redirect www to naked domain with ssl](http://stackoverflow.com/a/42869783/1165509)

>S3 Website features can be used in conjunction with Amazon CloudFront. However, S3 Website uses a different domain name than regular S3 buckets. In this case, you'll need to set the Origin Domain Name of your CloudFront distribution's origin configuration to new.rdegges.com.s3 website us east 1.amazonaws.com.

[S3]: Amazon Simple Storage Service
[CDN]: Amazon CloudFront – Content Delivery Network (CDN)
[Route 53]: Managed Cloud DNS - Domain Name System - Amazon Route 53 | AWS
[HTTPS]: Hypertext Transfer Protocol (HTTP) within a connection encrypted by Transport Layer Security
