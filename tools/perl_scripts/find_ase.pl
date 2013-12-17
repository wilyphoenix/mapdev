
# purpose: prints all ase's from a .map

$map = "ut4_superman2_beta";

open (MAP, "$map.map") || die $!;
while ($line = <MAP>) {
      if ($line =~ /^\"model\"/) {

        $line =~ s/^\"model\" \"//;  # scrub the line
        $line =~ s/\"\s*$//;

        $models{$line}++;  # remove duplicates with a hash
      }
}
close MAP;

    foreach $modelpath (sort keys %models) {  # show what models we modified in the .map
       print "$modelpath\n";

#      $modelpath =~ s/^(\S+)\/.*?$/$1/;  # strip the model file name from the path

    }