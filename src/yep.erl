-module(yep).
-export([module/2]).

module(Yaml, Filename) ->
    Erlang = header(Yaml, Filename),
    Erlang ++ functions(Yaml).

functions([Yaml]) ->
    [function(Function) || Function <- Yaml].

function({Declaration, Definition}) ->
    io_lib:format("~s ->~n~s.~n~n", [declaration(Declaration), definition(Definition)]).

declaration(Declaration) ->
    io_lib:format("~s", [Declaration]).

definition(Definition) ->
    io_lib:format("~s", [Definition]).

header(_Yaml, Filename) ->
    print:module(module_name(Filename)) ++ 
    print:compile("export_all") ++
    print:new_line().

module_name(Filename) ->
    Tokens = string:tokens(Filename, "."),
    lists:nth(1, Tokens).
    
