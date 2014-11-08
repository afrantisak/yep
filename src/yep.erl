-module(yep).
-export([main/1]).

main([Filename]) ->
    handle_file(file:open(Filename, read), Filename);
main(_) ->
    usage().

handle_file({ok, IoDevice}, Filename) ->
    read(IoDevice, Filename),
    file:close(IoDevice);
handle_file({error, enoent}, Filename) ->
    io:format("Could not find file ~s~n", [Filename]),
    halt(1).

usage() ->
    io:format("usage: yep <filename>~n"),
    halt(1).

read(Device, Filename) ->
    chars(io:get_chars(Device, '', 1024 * 1024), Device, Filename).

chars(eof, _Device, _Filename) ->
    ok;
chars({error, Reason}, _Device, _Filename) ->
    io:format("ERROR: ~p~n", [Reason]),
    {error, Reason};
chars(Data, Device, Filename) ->
    chunk(Data, Filename),
    read(Device, Filename).

chunk(Data, Filename) -> 
    ok = application:start(yamerl),
    Yaml = yamerl_constr:string(Data),
    Erlang = yep_erlang:module(Yaml, Filename),
    io:format("~s", [Erlang]).


