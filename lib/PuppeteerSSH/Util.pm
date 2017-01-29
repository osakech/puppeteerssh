#
#===============================================================================
#
#         FILE: Util.pm
#
#  DESCRIPTION: miscellaneous stuff
#
#       AUTHOR: Alexandros Kechagias (), osakech@gmail.com
#      VERSION: 0.1
#      CREATED: 01/20/2017 04:36:24 PM
#===============================================================================
package PuppeteerSSH::Util;

our $VERSION = '0.2';

use strict;
use warnings;
use Carp qw(carp croak);

sub mergeFiles {
    my ( $tmpFilePaths, $filename, $addTimestamp, $noMerge )       = @_;
    my $resultfile_file_name = _mergeFileName( $filename, $addTimestamp );
    _concatFiles($resultfile_file_name,$tmpFilePaths);
    #TODO if $nomerge ist set create seperate files with incr number or name of server
    _deleteTmpFiles($tmpFilePaths);
    return;
}

sub _deleteTmpFiles {
    my	( $tmpFilePaths )	= @_;

    foreach my $file ( @$tmpFilePaths) {
        unlink $file or carp "Could not unlink $file: $!";
    }

    return;
} ## --- end sub _deleteTmpFiles

sub _concatFiles {
    my	( $resultfile_file_name, $tmpFilePaths ) = @_;
    open my $resultfile, '>', $resultfile_file_name
      or croak "$0 : failed to open  output file '$resultfile_file_name' : $!\n";
    foreach my $tmpFile_file_name (@$tmpFilePaths) {
        open my $tmpFile, '<', $tmpFile_file_name
          or croak "$0 : failed to open  input file '$tmpFile_file_name' : $!\n";
        foreach my $line (<$tmpFile>) {

            print $resultfile $line;

        }
        close $tmpFile
          or carp "$0 : failed to close input file '$tmpFile_file_name' : $!\n";
    }
    close $resultfile
      or carp "$0 : failed to close output file '$resultfile_file_name' : $!\n";
    return ;
} ## --- end sub _concatFiles

sub _mergeFileName {
    my	( $filename, $addTimestamp ) = @_;
    my $ts                   = time();
    my $resultfile_file_name .= $filename // 'merged_result';
    $resultfile_file_name .= ((not $resultfile_file_name)?'':'_' ).$ts if $addTimestamp;

    return $resultfile_file_name;
} ## --- end sub _mergeFileName

1;
