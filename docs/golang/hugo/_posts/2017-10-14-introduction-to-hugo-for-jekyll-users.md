---
description: Basic Hugo concepts for Jekyll users.
---

## Overview

After building many websites with Jekyll for a while, I've decided to
try **Hugo** and was greatly impressed by its capabilities.

This article shows the main differences between Jekyll and Hugo
philosophies.

## includes

Jekyll includes have their equivalent in Hugo as
**[shortcodes](https://gohugo.io/content-management/shortcodes/)**.

> A shortcode is a simple snippet inside a content file that Hugo will
> render using a predefined template.

*Shortcodes* can be used to include code in posts, but in contrast to
Jekyll, to include content in templates you need to use **partial
templates** instead.

## WYSIWYG structure

The site structure is reflected in the website structure by default.

> Hugo believes that you organize your content with a purpose. The
> same structure that works to organize your source content is used to
> organize the rendered site.

The only thing that can be changed through front matter is the `slug`,
then the path will be the same as where it is located under the
`contents` folder.

For example: `content/posts/my-post.md` becomes
`example.com/posts/my-post/`.

The above statement reflects the original design that Hugo used to
have, now you can tweak some of that behaviour with front matter
variables or other configurations, for example to completely change
the destination path, the `url` variable can also be set as in Jekyll.

### Sections

Articles and posts goes into `/content`, each directory at
`content/<DIRECTORIES>` are special in Hugo and are called **Content
Sections**.

Each *section* can have nested directories, but all the content inside
them, will have the same base **section**, (i.e. the first directory
under `/content`).


## Inspect equivalent

There is a helpful `{%raw%}{{ <var> | inspect}}{%endraw%}` filter tag in Jekyll that
allows to print any variable in a template. The closest equivalent in
Hugo is the usage of `{%raw%}{{ print "%#v" <var> }}{%endraw%}`. [^printvars]

To print the current *Page* data `{%raw%}{{ printf "%#v" . }}{%endraw%}` will print:

- the top level object and
- object fields

E.g.: for a **Section** in `/content/communication` it will print something
like:

~~~ go
&hugolib.PageOutput{Page:(*hugolib.Page)(0xc4210f2a00), paginator:(*hugolib.Pager)(nil), paginatorInit:sync.Once{m:sync.Mutex{state:0, sema:0x0}, done:0x0}, targetPathDescriptor:hugolib.targetPathDescriptor{PathSpec:(*helpers.PathSpec)(0xc4200ca240), Type:output.Format{Name:"HTML", MediaType:media.Type{MainType:"text", SubType:"html", Suffix:"html", Delimiter:"."}, Path:"", BaseName:"index", Rel:"canonical", Protocol:"", IsPlainText:false, IsHTML:true, NoUgly:false, NotAlternative:false}, Kind:"section", Sections:[]string{"communication"}, BaseName:"_index", Dir:"communication/", LangPrefix:"", URL:"/communication/", Addends:"", ExpandedPermalink:"", UglyURLs:false}, outputFormat:output.Format{Name:"HTML", MediaType:media.Type{MainType:"text", SubType:"html", Suffix:"html", Delimiter:"."}, Path:"", BaseName:"index", Rel:"canonical", Protocol:"", IsPlainText:false, IsHTML:true, NoUgly:false, NotAlternative:false}}
~~~


[^printvars]: https://discourse.gohugo.io/t/how-to-debug-a-template/1027
