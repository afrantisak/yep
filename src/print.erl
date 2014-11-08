-module(print).
-compile(export_all).

directive(Directive, Value) ->
    io_lib:format("-~s(~s).~n", [Directive, Value]).

module(Module) ->
    directive("module", Module).

compile(Compile) ->
    directive("compile", Compile).

new_line() ->
    "\n".
