#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <markdown_lib.h>

MODULE = Text::Markdown::PegMarkdown		PACKAGE = Text::Markdown::PegMarkdown	PREFIX = TextMarkdown_

PROTOTYPES: DISABLE

SV *
TextMarkdown__markdown(text)
        char *text;
    PREINIT:
        SV* r = &PL_sv_undef;
        char *out = NULL;
        int extensions = 0;
        int output_format = HTML_FORMAT;
    CODE:
        out = markdown_to_string(text, extensions, output_format); 
        r = newSVpvn(out, strlen(out));

        Safefree(out);
        RETVAL = r;
    OUTPUT:
        RETVAL
