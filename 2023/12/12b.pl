#!perl -l
for (<>) {
  @a = split;

  $str = join '?',(($a[0])x5);
  $strlen = length($str);
  @lens = split ',', (join ',',(($a[1])x5));
  %cached = ();

  $n = num(0,0);
  $tot += $n;
}

print $tot;

# Find the number of matches. The args are as follows:
# The current position in the string $str
# The current position in the array of lengths @lens
# The array of lengths
sub num {
  my $p1 = shift;
  my $p2 = shift;

  # Have we cached this result already?
  if (exists $cached{$p1,$p2}) { return $cached{$p1,$p2} }

  # If we have run out of both string and lengths, it's a match
  # If we have run out of string but have lengths left, it's a mismatch.
  if ($p1 >= $strlen) { return ($cached{$p1,$p2} = ($p2 >= @lens)) }
  # If we have run out of lengths, it's a match only if there are no hashes left
  if ($p2 >= @lens) { return ($cached{$p1,$p2} = !($str =~ /^.{$p1}.*#/)) }

  # Can the next word start at position p1?
  # There need to be lens[p2] springs, followed by a space or end of line
  my $m;
  if ($str =~ /^.{$p1}[#\?]{$lens[$p2]}(\.|\?|$)/) {
    $m = num($p1 + $lens[$p2] + 1, $p2 + 1)  # then go onto the next length
  }
  # Unless we have a hash here, we can try the next position too
  unless ($str =~ /^.{$p1}#/) {
    $m += num($p1 + 1, $p2);
  }

  return ($cached{$p1,$p2} = $m);
}
