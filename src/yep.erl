-module(yep).
-export([main/1]).

main([Filename]) ->
    handle_file_open(file:open(Filename, read), Filename);
main(_) ->
    usage().

usage() ->
    io:format("usage: yep <filename>~n"),
    halt(1).

handle_file_open({ok, IoDevice}, Filename) ->
    read(IoDevice, Filename),
    file:close(IoDevice);
handle_file_open({error, enoent}, Filename) ->
    io:format("Could not find file ~s~n", [Filename]),
    halt(1).

read(Device, Filename) ->
    handle_get_chars(io:get_chars(Device, '', 1024 * 1024), Device, Filename).

handle_get_chars(eof, _Device, _Filename) ->
    ok;
handle_get_chars({error, Reason}, _Device, _Filename) ->
    io:format("ERROR: ~p~n", [Reason]),
    {error, Reason};
handle_get_chars(Data, Device, Filename) ->
    chunk(Data, Filename),
    read(Device, Filename).

chunk(Data, Filename) -> 
    ok = application:start(yamerl),
    Yaml = yamerl_constr:string(Data),
    Erlang = yep_erlang:module(Yaml, Filename),
    io:format("~s", [Erlang]).


