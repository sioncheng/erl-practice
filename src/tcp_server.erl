-module(tcp_server).

-export([start/0,start/1,stop/0]).

%%% ===================================
%%% API
%%% ===================================
start() ->
	start(2345).

start(Port) ->
	{ok, Listen} = gen_tcp:listen(Port, 
		[binary, 
		{packet, 0}, 
		{reuseaddr, true}, 
		{active, true}]),
	spawn(fun() -> loop_accpet(Listen) end).

stop() ->
	ok.


%%% ===================================
%%% internal functions
%%% ===================================
loop_accpet(Listen) ->
	{ok, Socket} = gen_tcp:accept(Listen),
	spawn(fun() -> loop_accpet(Listen) end),
	loop_socket(Socket).

loop_socket(Socket) ->
	receive
		{tcp, Socket, RawData} ->
			Echo = "you typed " ++ RawData,
			gen_tcp:send(Socket, Echo),
			loop_socket(Socket);
		{tcp_closed, Socket} ->
			io:format("tcp_close ~p ~n", [Socket]);
		{tcp_error, Socket, Reason} ->
			io:format("tcp_error ~p ~p ~n", [Socket, Reason])
	end.