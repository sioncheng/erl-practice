-module(lib_mics).
-export([for/3, sum/1]).

for(Max, Max, F) -> [F(Max)];
for(I, Max, F) -> [F(I) | for(I+1, Max, F)].

sum([H | T]) -> H + sum(T);
sum([]) -> 0.