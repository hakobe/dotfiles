#!/usr/bin/env perl

use strict;
use warnings;

use Cwd;
use File::Basename;
use File::Spec;

die "Too many arguments!\n" if @ARGV > 2;

my $cwd  = shift or die "No working directory.\n";
my $file = shift or die "No filename to check!\n";
my $dir  = dirname( $file ) . '/lib';

chdir($cwd);

# Error messages to be skipped.
my @skip = (
  '"DB::single" used only once: possible typo',
);

my $skip = join '|', @skip;
my @checks;

push @checks, '-M-circular::require' if `perldoc -l circular::require 2> /dev/null`;
push @checks, '-M-indirect'          if `perldoc -l indirect 2> /dev/null`;
push @checks, '-Mwarnings::method'   if `perldoc -l warnings::method 2> /dev/null`;
push @checks, '-Mwarnings::unused'   if `perldoc -l warnings::unused 2> /dev/null`;

# uninit is not included in 5.10 and later
push @checks, '-Muninit'             if ( $] < 5.010 ) && `perldoc -l uninit 2> /dev/null`;

my @incs;
push @incs, "-I lib";
push @incs, "-I t/lib";
push @incs, map { "-I $_" }  glob("modules/*/lib");

# need to turn on taint if it's on the shebang line.
# naive check for [tT] switch ... will both t and T ever be used at the same time?
my ( $taint ) = `head -n 1 $file` =~ /\s.*-.*?(t)/i;
push @checks, "-$taint" if defined $taint;

my $checks = join(' ', @checks);
my $incs = join(' ', @incs);
my $command = (-f "cpanfile") ?
    "carton exec @incs -- perl @checks -c $file 2>&1" :
    "perl @incs @checks -c $file 2>&1";

for my $line ( `$command` ) {
  chomp $line;
  next if $line =~ /$skip/;
  print $line;
}
