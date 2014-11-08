-module(yep_erlang).
-export([module/2]).

-compile(export_all).

module(Yep, Filename) ->
    header(Yep, Filename) ++ functions(Yep).

functions([Yep]) ->
    [function(Yep_function) || Yep_function <- Yep].

function({Yep_declaration, Yep_definition}) ->
    io_lib:format("~s ->~n~s.~n~n", [declaration(Yep_declaration), definition(Yep_definition)]).

declaration(Yep_declaration) ->
    Tokens = [evaluate(Token) || Token <- string:tokens(Yep_declaration, " ")],
    {Name_tokens, Arg_tokens, Filter_tokens} = tokens(Tokens),
    io_lib:format("~s(~s)~s", [name(Name_tokens), args(Arg_tokens), when_filters(filters(Filter_tokens))]).

evaluate(Token) ->
    {ok, A, _} = erl_scan:string(Token),
    A.

tokens(Tokens) ->
    %% find the first non-atom token, that will be the first arg
    {Name_tokens, Args_Filter} = lists:splitwith(fun(Token) -> token_is_atom(Token) end, Tokens),
    {Arg_tokens, Filter_tokens} = lists:splitwith(fun(Token) -> token_is_when(Token) end, Args_Filter),
    {Name_tokens, Arg_tokens, Filter_tokens}.

name(Name_tokens) ->
    string:join([token_atom_as_string(Name_token) || Name_token <- Name_tokens], "_").

args(Arg_tokens) ->
    string:join([token_string(Arg_token) || Arg_token <- Arg_tokens], ", ").

filters(Filter_tokens) ->
    string:join([token_string(Filter_token) || Filter_token <- Filter_tokens], " ").

when_filters([]) ->
    [];
when_filters(String) ->
    " when " ++ String.

token_is_atom([{atom, 1, _}]) ->
    true;
token_is_atom(_) ->
    false.

token_is_when([{"|", 1}]) ->
    false;
token_is_when(_) ->
    true.

token_atom_as_string([{atom, 1, Value}]) ->
    atom_to_list(Value).

token_string([{var, 1, Value}]) ->
    atom_to_list(Value);
token_string([{atom, 1, Value}]) ->
    atom_to_list(Value);
token_string([{string, 1, Value}]) ->
    "\"" ++ Value ++ "\"".

definition(Yep_expressions) ->
    string:join([expression(Yep_expression) || Yep_expression <- Yep_expressions], ",\n").

expression(Yep_expression) ->
    io_lib:format("    ~s", [Yep_expression]).

header(_Yep, Filename) ->
    print:module(module_name(Filename)) ++ 
    print:compile("export_all") ++
    print:new_line().

module_name(Filename) ->
    Tokens = string:tokens(Filename, "."),
    lists:nth(1, Tokens).
    
