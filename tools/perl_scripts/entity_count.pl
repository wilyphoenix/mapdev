
# Purpose: tells how many entities are in use in a map

$map = "ut4_superman2_beta.map";


open (MAP, $map) || die $!;

while ($line = <MAP>) {

  if ($line =~ /^\/\/ entity/) {
    $ec++;
    $efound = 1;  # we're in an entity block
    next;
  }
  if ($efound) {
    if ($line =~ /^\"classname\"/) {
      ($entity) = $line =~ /\s+\"(\S+)\"/;
      $class{$entity}++;
      $efound = 0;
      $ec_main++ if $entity =~ /trigger|func/;
    }
  }

}
close MAP;

print "Entity count:\n";

foreach $line (sort keys %class) {
  print "$line\t";
  print $class{$line};
  print "\n";
}

print "\nTotal entities: $ec\n";
print "\nTotal trigger/func: $ec_main\n";
