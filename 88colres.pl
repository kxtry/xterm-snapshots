#!/usr/bin/perl
# Author: Steve Wall <swall@redcom.com>
# $XFree86: xc/programs/xterm/88colres.pl,v 1.1 1999/09/25 14:38:23 dawes Exp $
# Made from 256colres.pl

# Construct a header file defining default resources for the
# 88-color model of xterm.

# use the resources for colors 0-15 - usually more-or-less a
# reproduction of the standard ANSI colors, but possibly more
# pleasing shades

print <<EOF;
/*
 * This header file was generated by $0
 */
/* \$XFree86\$ */
EOF

$line1="{\"color%d\", XtCForeground, XtRPixel, sizeof(Pixel),\n";
$line2="\tXtOffsetOf(XtermWidgetRec, screen.Acolors[%d]),\n";
$line3="\tXtRString, DFT_COLOR(\"rgb:%2.2x/%2.2x/%2.2x\")},\n";
@steps=(0,139,205,255);

# colors 16-79 are a 4x4x4 color cube
for ($red = 0; $red < 4; $red++) {
    for ($green = 0; $green < 4; $green++) {
	for ($blue = 0; $blue < 4; $blue++) {
	    $code = 16 + ($red * 16) + ($green * 4) + $blue;
	    printf($line1, $code);
	    printf($line2, $code);
	    printf($line3,
		   int (@steps[$red]),
		   int (@steps[$green]),
		   int (@steps[$blue]));
	}
    }
}

# colors 80-91 are a grayscale ramp, intentionally leaving out
# black and white
for ($gray = 0; $gray < 8; $gray++) {
    $level = ($gray * 23.18181818) + 46.36363636;
    if( $gray > 0 ) { $level += 23.18181818; }
    $code = 80 + $gray;
    printf($line1, $code);
    printf($line2, $code);
    printf($line3,
	   int($level), int($level), int($level));
}
