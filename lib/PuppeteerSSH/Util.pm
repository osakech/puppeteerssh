#
#===============================================================================
#
#         FILE: Util.pm
#
#  DESCRIPTION: miscellaneous stuff
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Alexandros Kechagias (), osakech@gmail.com
# ORGANIZATION:
#      VERSION: 0.1
#      CREATED: 01/20/2017 04:36:24 PM
#     REVISION: ---
#===============================================================================
package PuppeteerSSH::Util;

our $VERSION = '0.1';

use strict;
use warnings;

sub mergeFiles {
    my ($tmpFilePaths)       = @_;
    my $ts                   = time();
    my $resultfile_file_name = "merged_result_$ts";    # output file name

    open my $resultfile, '>>', $resultfile_file_name
      or die "$0 : failed to open  output file '$resultfile_file_name' : $!\n";
    foreach my $tmpFile_file_name (@$tmpFilePaths) {
        open my $tmpFile, '<', $tmpFile_file_name
          or die "$0 : failed to open  input file '$tmpFile_file_name' : $!\n";
        foreach my $line (<$tmpFile>) {

            print $resultfile $line;

        }
        close $tmpFile
          or warn "$0 : failed to close input file '$tmpFile_file_name' : $!\n";
    }
    unlink @$tmpFilePaths;
    close $resultfile
      or warn "$0 : failed to close output file '$resultfile_file_name' : $!\n";
}

1;

