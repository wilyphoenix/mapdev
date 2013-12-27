# Perl for Windows

## Author: DB / wily
## Date: 12/25/2013
## Purpose: display all files that are duplicates by comparing names and verifying identity with size
## Notes: Due to checking properties of each file, this script is SLOW. Takes like 10 minutes to run.
##
## Running this in a q3ut4 folder will loosely determine what assets are duplicated. To see this run
## against vanilla 4.2, a fresh install of 4.2 is necessary, followed by an unzip of all 4.2 assets
## into another folder. The script is only somewhat accurate due to many variables in how each
## asset may be used. Consider this script a dipstick of measuring wasted assets.


$readcache = 0;   # Flag to cause dir CLI commands to be cached or read from cache. Change to 1 next run.
$max_parse = 100; # Percentage of parsing computed before moving to output, 1-100%
$updates = 5;     # Number of intervals between ETA updates


$start = time;  # Takes so long I built time tracking in. O_o

open (LOG, ">dupelog.txt") || die $!;  # keep the output in a file


## Produce a dir list recursively for further parsing
if ($readcache) {
  print "Reading cache\n";
  open (CACHE, "cachedfilelist.txt");
  @dirlist = <CACHE>;
} else {
  print "No caching\n";
  open (CACHE, ">cachedfilelist.txt");
  @dirlist = `dir /S /B`;
  @dirlist = map { lc } @dirlist;  # lowercase the array
}

foreach $dirclean (@dirlist) {
  next if $dirclean !~ /\./;
  chomp $dirclean;
  push @list, $dirclean;
  print CACHE "$dirclean\n" if ! $readcache;
}

close CACHE;


## this script is REALLY SLOW, so let's make a progress meter
$listsize = @list;
$listpercent = int($listsize / 100);
&pint("Number of assets: $listsize\n");

print "Percent complete: 0";


## iterate through the dir list output
foreach $file (@list) {

## progress meter
  $listcount++;
  $listprintcount = int($listcount / $listpercent);
  if ($listprint < $listprintcount) {
    $listprint++;

    $now = time;
    $delay = $now - $start;
    $etatime = ($delay / $listcount) * (100 - $listprintcount);
    $etamin = int ($etatime / 60);
    $etasec = $etatime - ($etamin * 60);
    if ($listprintcount % $updates == 0) {
      print "\nETA: $etamin min, $etasec sec\n";
    }

    print "..$listprint";
    $lasttime = time;

  }

  ($dir,$name) = $file =~ /^(.+\\)(.+)$/;  # get dir and file name
  next if $name !~ /\S+/;  # it's a dir then

#  if (! $readcache) { } # no alt method yet to cache this command
  $fileinfo = `dir /-C "$dir$name"`;  # file info with no commas, this is the slow part

  ($filesize) = $fileinfo =~ /[AM|PM]\s+(\d+)/s;  # need the file size to track definitive dupes

  if ($filesize !~ /\d+/) {  # shouldn't happen, fix the code if it does
    print " * break: filesize=$filesize;name=$name;\n";
    print "$fileinfo\n";
    <STDIN>;  # wait for input or ctrl-c out
  }

  $asset{$name}{$filesize}++;  # track specific instances of this asset
  $asset{$name}{"instance"}++;  # track all instances of this named asset

  last if $listprint > $max_parse;  # for testing, bail after X% assets parsed

}


## Now with all assets indexed, display files that are dupes
foreach $file (keys %asset) {

  $file_instances = $asset{$file}{"instance"};  # number of times the file name appears
  &pint("\n") if $file_instances > 1;

  $waste = 0;

  foreach $size (keys $asset{$file}) {
    next if $size eq "instance";

    $assetcount = $asset{$file}{$size};
    $redundant += $assetcount - 1;

    $waste += $size * ($assetcount - 1);

    @dupes = ();  # clear this array first

    if ($assetcount > 1) {

      $totaldupes++;

      &pint("Named file $file \@ $size bytes, ");
      &pint("Wasted $waste bytes, ") if $waste;
      &pint("found $assetcount times:\n");

      @dupes = grep (/\\$file\s*$/, @list);
      foreach $line (@dupes) {

        $fileinfo = `dir /-C "$line"`;  # could DOS be any less useful?
        ($filesize) = $fileinfo =~ /(\d+) $file/s;  # have to double-check each dupe

        if ($filesize == $size) {  # k, the sizes match
          chomp $line;
          &pint("$size bytes: $line\n");
        }
      }

    }

    if ($file_instances > $assetcount) {  # The file has a dupe, but it isn't the same size
      &pint("Non-unique asset name, possible dupe: $file \@ $size bytes\n");
    }

  }

  $totalwaste += $waste;

  if ($file_instances > 1) {
    &pint("Total duplicate file NAME instances found: $file_instances\n");
    @dupes = ();  # clear this array first
    @dupes = grep (/\\$file\s*$/, @list);
    foreach $line (@dupes) {
      print "$line\n";
    }
  }


}


&pint("\nTotal bytes wasted: $totalwaste\n");
&pint("Total number of duplicate instances: $totaldupes\n");
&pint("Total number of redundant files: $redundant\n");

$end = time;
$timedif = $end - $start;
$min = int ($timedif / 60);
$sec = $timedif - ($min * 60);

&pint("Total time: $min min, $sec sec\n");


close LOG;

exit;



## Just a print sub to split output
sub pint {

  my $ptext = shift @_;
  print $ptext;
  print LOG $ptext;

}