#!perl
@d=<>=~/./g;map{@a=/\w+/g;$m{$a[0]}=[$a[1],$a[2]]}<>;for($,=AAA;$,ne ZZZ;){$,=$m{$,}[$d[$i++%@d]eq'R']}print$i
