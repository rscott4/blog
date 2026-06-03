= I created a blog!
Welcome to my new blog!

My plan is to periodically write on here. About anything that crosses my
mind. Rants, guides, news, all-sorts.

But as of right now it's 4 AM and I need to get to bed!

== How it's made

A #link("https://git.sr.ht/~rscott/blog")[git repository] houses the
blog and has a makefile with the following targets:
+ Generate JSON index.
+ Compile typst to HTML.
+ Compile typst to PDF.

Then #link("https://git.sr.ht/~rscott/www")[another repository] houses
the website including the blog. The blog has javascript designed to
query the JSON index and present the HTML that was generated earlier.
