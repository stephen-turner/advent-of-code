#!perl -l
@lines = <>;
$_ = shift(@lines);
@seedpairs = /(\d+ \d+)/g;

for $seedpair (@seedpairs) {
  @seedpair = ($seedpair =~ /(\d+) (\d+)/);
  for ($seed = $seedpair[0]; $seed < $seedpair[0] + $seedpair[1]; $seed += $skip) {
    $last = $seed;
    $next = -1;
    $skip = 1e10;

    for (@lines) {
      if (/(\d+) (\d+) (\d+)/) {
        # Three numbers on the line: look if we can map, and what range above it is still good
        if ($last >= $2 && $last < $2 + $3) {
          $next = $1 + $last - $2;
          $canskip = $2 + $3 - $last;
          $skip = $canskip if $canskip < $skip;
        }
        elsif ($last < $src[$_]) {
          $canskip = $2 - $last;
          $skip = $canskip if $canskip < $skip;
        }
      } else {
        # Not three numbers on the line: we are moving to the next block
        $last = $next if $next > -1;  # Otherwise $last is unchanged
        $next = -1;
      }
    }
    $last = $next if $next > -1;
    $ans = $last if (not defined $ans or $last < $ans);
  }
}

print $ans;
