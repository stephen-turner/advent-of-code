#!perl
while(<>){
  my%a;
  # How many instances of each number?
  $a{$_}++for/(\d+)\s/g;
  # The score is the number of twos
  $s=grep{$_>1}values%a;
  # In %n we store the number of instances of each scratchcard
  # And in $n the total number. We'll increment the latter from this row.
  $n+=++$n{$.};
  # And now increment later scratchcards depending on this one
  $n{$_}+=$n{$.}for($.+1..$.+$s);
}
# Print the final number
print"$n\n";
