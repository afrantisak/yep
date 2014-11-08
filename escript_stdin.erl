%% -*- erlang -*-
%% usage:
%%  #!/usr/bin/env escript
%%  -include("escript_stdin.erl").
%%  progname() -> "program_name_for_usage_text".
%%  chunk(Data) -> io:format("Input file:~n~s~n", [Data]).
main([]) ->
    read(standard_io);
main([Filename]) ->
    handle_file(file:open(Filename, read), Filename);
main(_) ->
    usage().

handle_file({ok, IoDevice}, _Filename) ->
    read(IoDevice),
    file:close(IoDevice),
    0;
handle_file({error, enoent}, Filename) ->
    io:format("Could not find file ~s~n", [Filename]),
    1.    

usage() ->
    io:format("usage: ~s <filename (defaults to stdin)>~n", [progname()]),
    halt(1).

read(Device) ->
    chars(io:get_chars(Device, '', 1024 * 1024), Device).

chars(eof, _Device) ->
    ok;
chars({error, Reason}, _Device) ->
    io:format("ERROR: ~p~n", [Reason]),
    {error, Reason};
chars(Data, Device) ->
    chunk(Data),
    read(Device).


