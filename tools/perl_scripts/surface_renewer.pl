#!/usr/bin/perl

## Dan Barrett
## 3/28/2009
## Program: surface_renewer.pl
## Purpose: Takes a new surface file, integrates the old, shows what's left.


## NOTES, USAGE:
## 1. This script will expect the file ut4_yourmap.surface.current is the last good, complete, .surface file with
## all surfaces assigned. This script will finish by overwriting the .surface file and creating a new .current file.
## 2. Use the surface_generator (bsp.exe) to create your new .surface file. Get that file in this directory.
## 3. Execute ./surface_renewer.pl ut4_yourmapname


$map = $ARGV[0] || "ut4_ss_b1";  # Either supply the map name via CLI or statically assign it here.

$map =~ s/\.surface.*?$// if $map =~ /\.surface.*?$/;

$map_cur = "$map.surface.current";
$map_raw = "$map.surface";


open (CUR, "$map_cur") || die ("Could not open $map_cur. This is the last good .surface file with a .current suffix.\n");
open (RAW, "$map_raw") || die ("Could not open $map_raw. This is the new .surface file you create with bsp.exe\n");


## First collect the new texture info
while ($raw_line = <RAW>) {

## wipe all unnecessary whitespace
  $raw_line =~ s/\s+$//;
  $raw_line =~ s/^\s*//;
  next if $raw_line !~ /\S+/;

## collect information
  ($tex,$surf) = split (/\s+\=\s+/, $raw_line);

  $db{$tex} = $surf;
}



## Now compare against the old, drop lines that no longer exist
while ($cur_line = <CUR>) {

## wipe all unnecessary whitespace
  $cur_line =~ s/\s+$//;
  $cur_line =~ s/^\s*//;
  next if $cur_line !~ /\S+/;

## collect information
  ($tex,$surf) = split (/\s+\=\s+/, $cur_line);

  if ($db{$tex} !~ /\S+/) {  # no longer using this texture
    push @old, "$tex = $surf";
    next;
  }

  $db{$tex} = $surf;
}


close RAW;
close CUR;


#`cp $map_cur $map_cur.backup`;  # *nix version of copy
`copy $map_cur $map_cur.backup`;  # windows version of copy

open (CUR, ">$map_cur") || die ("Could not write to $map_cur. File permissions?\n");
open (RAW, ">$map_raw") || die ("Could not write to $map_raw. Wrote a backup of the current file ($map_cur.backup)\n");


## queue up the new entries
foreach $line (sort @none) {
  push (@output, "$line");
}



## queue up the "none" entries
foreach $line (sort keys %db) {
  $cursurf = $db{$line};
  next if $cursurf ne "none";
  push @output, "$line = $cursurf";
}

## queue up the existing entries
foreach $line (sort keys %db) {
  $cursurf = $db{$line};
  next if $cursurf eq "none";
  push @output, "$line = $cursurf";
}


foreach $line (@output) {
  next if $line =~ /mapobjects/;
  print CUR "$line\n";
  print RAW "$line\n";
}

foreach $line (@output) {
  next if $line !~ /mapobjects/;
  print CUR "$line\n";
  print RAW "$line\n";
}



close RAW;
close CUR;


print "\nComplete. Wrote $map_raw and $map_cur.\n\n";

print "Obsolete textures:\n";
foreach $line (@old) {
  print "$line\n";
}

print "\n\nNow copy the .surface file back to your map/ directory, and run the surface_compiler.\n\n";

