#!perl
map{$n+=$,=++$n[++$i];$n[$_]+=$,for$i+1..$i+(@s=/\b(\d+)\s(?=.*\b\1\b)/g)}<>;print$n
