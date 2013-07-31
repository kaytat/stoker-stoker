#
# Copyright (c) 2013 kaytat
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

#
# $File: //depot/stoker_git/stoker/tini/examples/stoker/build_ver.pl $
# $Date: 2013/07/30 $
# $Revision: #2 $
# $Author: kaytat $
#

BEGIN {
    if ($^O =~ /MSWin32/) {
        require Win32::File;
        Win32::File->import();
        Win32::File::SetAttributes($ARGV[0], 0);
    } else {
        chmod 0644, $ARGV[0];
    }
}

open VER, "<", $ARGV[0] or die "Can't open for reading: $ARGV[0]\n";

my $ver_txt = <VER>;
my @vers = split(/\./, $ver_txt);
$vers[3] += 1;
close VER;

open VER, ">", $ARGV[0] or die "Can't open for writing: $ARGV[0]\n";
print VER "$vers[0].$vers[1].$vers[2].$vers[3]\n";
close VER;

print "package stoker\;\n";
print "final public class Version{\n";
print "public static final byte\[\] rev_bytes = \{";
print "(byte)" . $vers[3] . ",";
print "(byte)" . $vers[2] . ",";
print "(byte)" . $vers[1] . ",";
print "(byte)" . $vers[0] . "\}\;\n";
print "public static final String rev = \"$vers[0].$vers[1].$vers[2].$vers[3]\";\n";
print "public static final String get_version() {\n";
print "return rev;\n";
print "}\n";
print "}\n";
