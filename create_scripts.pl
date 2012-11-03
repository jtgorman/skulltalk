#!/usr/bin/env perl

use strict ;
use warnings ;

open my $lines, '<', $ARGV[0] or die "Could not open file $! \n" ;


while (my $line = <$lines>) {

    chomp($line) ;
    my $file_name = $line ;

    $file_name =~ tr/ /_/ ;
    $file_name =~ s/\'//g ;
    $file_name =~ s/,//g ;

    
    $file_name = substr($file_name,0,16) . ".script" ;
    my $dir = "scripts/" ;
    
    open my $script_file, '>', $dir . $file_name or die "Couldn't open script file scripts/${file_name}, $!" ;

    #print $script_file "(voice_us1_mbrola)\n";
    #print $script_file qq|(SayText "$line")\n|;

    print $script_file $line . "\n" ;
    
    # apparently, I though thti swas needed, but can also just do..
    # text2wave -eval '(voice_us1_mbrola)',
   
}
