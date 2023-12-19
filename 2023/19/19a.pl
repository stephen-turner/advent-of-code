#!perl -l
map{/{(.*)}/;@r=split',',$1;if(!$`){eval"\$$_"for@r;for($r=in;AR!~$r;){map{eval$_->[0]&&($r=$_->[1])&&next}@{$r{$r}}}$t+=$x+$m+$a+$s if(A=~$r)}$r{$`}=[map{/:/?["\$$`",$']:[1,$_]}@r]}<>;print$t
