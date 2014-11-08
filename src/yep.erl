-module(yep).
-export([get_erlang/2]).

get_erlang(Yaml, Filename) ->
    Erlang = print(directive, "module", Filename),
    Erlang ++ io_lib:format("~p~n", [Yaml]).

print(directive, Directive, Value) ->
    io_lib:format("-~s(~p).~n", [Directive, Value]).
