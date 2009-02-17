Text-Markdown-PegMarkdown
=========================

Perl extension for John MacFarlane's [peg-markdown](http://github.com/jgm/peg-markdown/), 
an implementation of markdown in C, using a PEG (parsing expression grammar).

INSTALLATION
============

To install this module type the following:

    perl Makefile.PL
    make
    make test
    make install

If you have a trouble with downloading a tarball from github.com
during "perl Makefile.PL". Try to use "git" instead.

    git clone git://github.com/jgm/peg-markdown.git jgm-peg-markdown

And then, run "perl Makefile.PL" again.

    rm jgm-peg-markdown-0.4.4.tar.gz
    perl Makefile.PL

DEPENDENCIES
============

peg-markdwon requires [glib2](http://www.gtk.org/download.html).
So Makefile.PL does.
