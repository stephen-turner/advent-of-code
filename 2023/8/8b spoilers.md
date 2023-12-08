I found part 2 of today's puzzle rather unsatisfactory.

Solving it in a reasonable time relies on noticing property $P$: that for each start node (`bcA`, say), an end node (`deZ`, say) is reached at times $k$, $2k$, $3k$, ...
(for some $k$ depending on the start node). Then you can take the LCM of all the $k$'s. But there is no reason why this should be the case.
* It's not guaranteed that if `bcA` reaches `deZ` at time $k$, then you reach `deZ` again at time $2k$.
This relies on the nodes out of `deZ` being the same as the nodes out of `bcA`.
* Now if that was the only issue, you could still solve the puzzle using the Chinese Remainder Theorem, but
it's not even guaranteed that if `deZ` gets back to `deZ` in $k$ steps, then it gets back again in another $k$ steps.
This relies on $k$ being constructed to be a multiple of the number of (L, R) instructions on the first line of the input file.

In other words, the file is very carefully constructed to have property $P$, and most valid files, meaning ones that do terminate eventually, don't have property $P$.
So we haven't solved the general case.

E.g.
```
LRLRR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11C, 11B)
11C = (XXX, 11D)
11D = (11F, 11Z)
11F = (XXX, 11G)
11G = (XXX, 11Z)
22A = (22B, XXX)
22B = (XXX, 22C)
22C = (22D, 22Z)
22D = (XXX, 22E)
22E = (XXX, 22F)
22F = (22Z, 22B)
22Z = (XXX, 22G)
22G = (22H, XXX)
22H = (XXX, 22C)
```
Track 11 terminates at times 2, 5, 10. Track 22 terminates at times 6, 10. 
