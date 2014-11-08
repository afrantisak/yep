-module(yep).
-export([module/2]).

module(Yaml, Filename) ->
    header(Yaml, Filename) ++ functions(Yaml).

functions([Yaml]) ->
    [function(Function) || Function <- Yaml].

function({Declaration, Definition}) ->
    io_lib:format("~s ->~n~s.~n~n", [declaration(Declaration), definition(Definition)]).

declaration(Declaration) ->
    io_lib:format("~s", [Declaration]).

definition(Expressions) ->
    string:join([expression(Expression) || Expression <- Expressions], ",\n").

expression(Expression) ->
    io_lib:format("    ~s", [Expression]).

header(_Yaml, Filename) ->
    print:module(module_name(Filename)) ++ 
    print:compile("export_all") ++
    print:new_line().

module_name(Filename) ->
    Tokens = string:tokens(Filename, "."),
    lists:nth(1, Tokens).
    
