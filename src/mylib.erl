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
    {ok, Q} = list_max(Qs),
    Q.

list_max([]) -> empty;
list_max([H | T]) -> {ok, list_max(H, T)}.

list_max(X, []) -> X;
list_max(X, [H | T]) when X < H -> list_max(H, T);
list_max(X, [_ | T]) -> list_max(X, T).
