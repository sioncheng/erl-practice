-module(lib_guard).
-export([maxA/1]).

maxA({a,N}) ->  
    if
        N > 3 ->
            N - 3;
        true ->
            N
    end.