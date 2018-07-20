-module(mylib).

%% API exports
-export([main/1]).

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main(_Args) ->
    Prices = [1, 5, 8, 9, 10, 17, 17, 20, 24, 30],
    Max_Profile = rod_cutting(Prices, 10),
    io:format("Args: ~p~n", [Max_Profile]),
    erlang:halt(0).

%%====================================================================
%% Internal functions
%%====================================================================

rod_cutting(_Prices, 0) -> 0;
rod_cutting(Prices, Length) ->
    Qs = lists:map(fun (I) ->
			   lists:nth(I, Prices) +
			     rod_cutting(Prices, Length - I)
		   end,
		   lists:seq(1, Length)),
    lists:max(Qs).
