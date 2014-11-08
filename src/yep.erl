-module(yep).
-export([get_erlang_module/2]).

get_erlang_module(Yaml, Filename) ->
    Erlang = header(Yaml, Filename),
    Erlang ++ get_erlang_functions(Yaml).

get_erlang_functions(Yaml) ->
    io_lib:format("~p~n", [Yaml]).

header(_Yaml, Filename) ->
    print(module, module_name(Filename)) ++ 
    print(compile, "export_all") ++
    print(new_line).

module_name(Filename) ->
    Tokens = string:tokens(Filename, "."),
    lists:nth(1, Tokens).
    
print(directive, Directive, Value) ->
    io_lib:format("-~s(~s).~n", [Directive, Value]).

print(module, Module) ->
    print(directive, "module", Module);
print(compile, Compile) ->
    print(directive, "compile", Compile).

print(new_line) ->
    "\n".
