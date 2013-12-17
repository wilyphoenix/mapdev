#!/usr/bin/perl

## Dan Barrett
## 4/17/2009
## Program: texture_renewer.pl
## Purpose: Parses a .map and .shader file, reveals what texture files are in use, and what textures/shaders are in use.
## Version: 1.2 - 04022010.1 - Wasn't listening to files within shader passes.
##          1.1 - 04022010.0 - Now parses all shaders in scripts/ folder.
##          1.0 - 04172009.0 - Works correctly.
## Bugs:    Doesn't parse animap.

## NOTES, USAGE:
## Put this script in the maps/ dir. Specify the map name (without the .map extension). The script does the rest.
## usage: texture_renewer.pl [map]


## Specify the map name if not using the CLI args
$map = "ut4_ss_b1";




$map = shift @ARGV if ($ARGV[0]);  # or specify one via CLI
$map =~ s/\.map$//;


open (MAP, "$map.map") || die ("$map.map not found");

while ($map_line = <MAP>) {
  chomp;
  next if $map_line =~ /\/\//;  # skip comment lines
  $s_line =~ tr/A-Z/a-z/;
  ($texture) = $map_line =~ /(\S+\/\S+)/;
  $table{$texture} = "map" if $texture;
}

close MAP;


$files = `dir /B "../scripts/*.shader"`;


foreach $shader_file (split (/\n/, $files)) {
  chomp $shader_file;
  next if $shader_file !~ /\S+/;

  open (SHADER, "../scripts/$shader_file") || die ("scripts/$shader_file not found");

  $inc_shader = 0;

  while ($s_line = <SHADER>) {
    $s_line =~ s/\s+$//;
    $s_line =~ s/^\s+//;
    $s_line =~ tr/A-Z/a-z/;

    next if $s_line =~ /^\/\//;

    ($shader) = $s_line =~ /textures\/(\S+\/\S+)$/;
    $shader =~ s/\.\S+$//;

    if ($s_line =~ /^textures\//) {

      if ($table{$shader} =~ /\S+/) {
        $local_shader = 1;
      } else {
        $local_shader = 0;
      }
    }

    next if ! $local_shader;

    $s_line =~ s/^map\s+//;
    $s_line =~ s/\s*\/\/.+$//;  # get rid of trailing comments

    next if $s_line !~ /^textures\//;
    next if $s_line =~ /qer_editorimage/;

    next if $s_line !~ /\S+/;

    $s_ext = "";  $s_ext2 = "";

    ($s_group) = $shader =~ /^(\S+)\//;
    ($s_file) = $shader =~ /\/(\S+?)$/;
    ($s_ext) = $s_line =~ /\.(\S\S\S)$/ if $s_line =~ /\./;

    next if $s_group eq "common";


    if ($s_ext) {  # getting 'textures/shader/name' and '.tga' for example
      if (! -e "../textures/$shader\.$s_ext") {
        print "Did not find texture file: \"textures/$shader\.$s_ext\"";
        $s_ext2 = "jpg" if -e "../textures/$s_name\.jpg";
        $s_ext2 = "tga" if -e "../textures/$s_name\.tga";  # tga has higher priority
        print " ... real file found: textures/$s_name\.$s_ext2" if $s_ext2;
        print "\n";
        $s_ext = $s_ext2 if $s_ext2;
      }

    } else {
      $s_ext = "jpg" if -e "../textures/$s_group/$s_file\.jpg";
      $s_ext = "tga" if -e "../textures/$s_group/$s_file\.tga";
      $s_ext2 = "shader";
    }


    $table{$shader} = "shader" if ! $s_ext;
    $table{$shader} = "$s_ext" if $s_ext;
    $table{$shader} = "shader $s_ext" if $s_ext && $s_ext2 eq "shader";


    if ($table{$shader} =~ /tga/ || $table{$shader} =~ /jpg/) {
      $known = "$shader\.$s_ext";
      push (@active_tex, $known) if ! $dupe{$known}++;
      $group{$s_group}++;
    }

    if ($table{$shader} =~ /shader/) {
      push (@active_shader, "$shader_file : $shader") if ! $dupe{$shader}++;
      $group{$s_group}++;
    }

    $s_ext = "";
    $s_ext2 = "";
    $known = "";

  }

  close SHADER;

}


print "\n\nActive shaders:\n\n";
foreach $active (sort @active_shader) {
  print "$active\n";
}


`rmdir /S /Q ..\\textures\\$map\\renew`;

print "\n\n";
foreach $g_dir (keys %group) {  # make the sub directories for the shader groups
  $g_dir =~ s/\//\\/g;
  print "creating: textures\\$map\\renew\\$g_dir\n";
  `mkdir ..\\textures\\$map\\renew\\$g_dir`;
}


print "\n\nActive textures:\n\n";
foreach $active (sort @active_tex) {
  if (! -e "..\\textures\\$active" && $active != /\./) {
    $try_active = $active;
    if ($try_active =~ /\.jpg/) {
      $try_active =~ s/\.jpg/\.tga/;
    } elsif ($try_active =~ /\.tga/) {
      $try_active =~ s/\.tga/\.jpg/;
    }

    if (! -e "..\\textures\\$try_active") {
      print "Could not find texture $active\n";
      next;
    } else {
      print "Wrongly specified texture $active, replacing with $try_active\n";
      $active = $try_active;
    }
  }

  print "$active";
  if (! -e "..\\textures\\$active") {
    print " - could not find, probably in a .pk3 or other shader\n";
    next;
  }
  print "\n";
  $active =~ s/\//\\/g;
  ($group) = $active =~ /^(\S+)\\/;
  `copy ..\\textures\\$active ..\\textures\\$map\\renew\\$group`;

}


print "\n\nCopied active textures to textures/$map/renew/\n\n";


exit;


