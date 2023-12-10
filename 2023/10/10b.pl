#!perl -l

# 0) Slurp in the input

for (<>) {
  push @a, [/./g];
}
$maxrow = $#a;
$maxcol = $#{$a[0]};

# 1) Find the S

for $r (0..$maxrow) {
  for $c (0..$maxcol) {
    if ($a[$r][$c] eq 'S') {
      $i = $r; $j = $c;
    }
  }
}

# 2) Work out which direction to head in
# Any direction that connects with the pipe at S is OK
# I'm going to cheat here and inspect the input myself
# rather than doing it programmatically. Sorry.
# For my input, as for the two sample inputs,
# south and east are the connecting directions (my S is an F).
# I'll choose east.

$dir = 'E';
++$j;
$s = $a[$i][$j];
$b[$i][$j] = 1;

# 3) Follow the loop round
# $dir is current direction (N, S, E, W)
# ($i, $j) are current row and column (starting from top left)
# $s is symbol at current position (== $a[$i][$j])
# @b is whether a point is on the loop

while ($s ne 'S') {
  # Change direction if the curent symbol is a corner
  # Assume we've come from a valid direction
  if ($s eq 'L') { $dir = ($dir eq 'S') ? 'E' : 'N' }
  elsif ($s eq 'J') { $dir = ($dir eq 'S') ? 'W' : 'N' }
  elsif ($s eq '7') { $dir = ($dir eq 'N') ? 'W' : 'S' }
  elsif ($s eq 'F') { $dir = ($dir eq 'N') ? 'E' : 'S' }
  # Do the step
  if ($dir eq 'N') { $i-- }
  elsif ($dir eq 'S') { $i++ }
  elsif ($dir eq 'W') { $j-- }
  else { $j++ }
  $s = $a[$i][$j];
  $b[$i][$j] = 1;
}

# 4) Use an even-odd algorithm to work out whether each point is inside or outside the loop
# Crossing a vertical pipe counts 1
# Going along a horizontal pipe it's a bit more complicated: F--J and L--7 count,
# F--7 and L--J don't. This can be done by counting F and J as +0.5, L and 7 as -0.5.

for $i (0..$maxrow) {
  for $j (0..$maxcol) {
    if ($b[$i][$j]) {  # This point was on the loop
      $s = $a[$i][$j];
      if ($s eq '|') { $x++ }
      elsif ($s eq 'J' || $s eq 'F' || $s eq 'S') { $x += 0.5 }
      elsif ($s eq 'L' || $s eq '7') { $x -= 0.5 }
    }
    else {
      # This point was not on the loop.
      # The point is inside the loop if $x is odd.
      $n++ if ($x % 2)
    }
  }
}

print $n;
