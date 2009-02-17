use strict;
use warnings;

use ExtUtils::MakeMaker;

my $PegMarkdownVersion = '0.4.4';

my $download_url = 'http://github.com/jgm/peg-markdown/tarball/'.$PegMarkdownVersion;
my $symlink = 'peg-markdown';

if (! (-l $symlink && -e $symlink) ) {
    opendir (DIR, '.');
    my @files = readdir(DIR);
    my @dirs = sort { (stat(_))[9] }
               grep { /^(jgm-peg-markdown|peg-markdown)/ }
               grep { -d } @files;
    my $target_dir;
    if (! @dirs ) {
        $target_dir = 'jgm-peg-markdown-' . $PegMarkdownVersion;
        my $tgz = $target_dir . '.tar.gz';
        if (! -e $tgz) {
            prompt(join("\n",
                "In order to make a dynamic library, Text::Markdown::PegMarkdown needs",
                "John MacFarlane's peg-markdown on github.com",
                "http://github.com/jgm/peg-markdown/tree",
                "",
                "This script is going to download a tarball from",
                "$download_url",
                "",
                "(press Enter to proceed)"));
            system('wget', '-O', $tgz, $download_url);
        }
        system('tar', 'xfz', $tgz);
    }
    closedir DIR;
    ## lazy re-readdir
    opendir (DIR, '.');
    @dirs = sort { (stat(_))[9] }
            grep { /^(jgm-peg-markdown|peg-markdown)/ }
            grep { -d } readdir(DIR);

    if ( @dirs ) {
        $target_dir = $dirs[0];
        unlink $symlink;
        symlink $target_dir, $symlink;
    } 
}


sub MY::postamble {
    return <<'MAKE_FRAG';
$(MYEXTLIB):
	(cd ext; make libpeg_markdown.$(DLEXT))
MAKE_FRAG
}
WriteMakefile(
    NAME              => 'Text::Markdown::PegMarkdown',
    VERSION_FROM      => 'lib/Text/Markdown/PegMarkdown.pm',
    PREREQ_PM         => {},
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Text/Markdown/PegMarkdown.pm', # retrieve abstract from module
       AUTHOR         => 'Masayoshi Sekimura <sekimura@cpan.org>') : ()),
    LIBS              => [`pkg-config --libs glib-2.0`],
    INC               => '`pkg-config --cflags glib-2.0` -Ipeg-markdown',
    MYEXTLIB          => 'ext/libpeg_markdown.$(DLEXT)',
);

