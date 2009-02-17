use 5.008000;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

sub MY::postamble {
    return <<'MAKE_FRAG';
MARKDOWN_OBJS=markdown_lib.o markdown_output.o markdown_parser.o

$(MARKDOWN_OBJS):
	(cd ../peg-markdown; make)
	@ for i in $@; do \
	    $(CP) ../peg-markdown/$$i .;\
	done

libpeg_markdown.$(DLEXT): $(MARKDOWN_OBJS)
	$(LD) $(LDDLFLAGS) -o libpeg_markdown.$(DLEXT) $(MARKDOWN_OBJS)
MAKE_FRAG
}

WriteMakefile(
    NAME              => 'libpeg_markdown',
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    LIBS              => `pkg-config --libs glib-2.0`,
    DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    INC               => `pkg-config --cflags glib-2.0`,
    # OBJECT            => '$(O_FILES)', # link all the C files too
    clean => { FILES => '*.so *.o'}, 
);
