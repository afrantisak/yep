-module(sample).
-export([lexical_cast]).

-spec lexical_cast(Value::integer, Type::string) -> ReturnType.
lexical_cast(Value, to, "string") when is_integer(Value) ->
    io_lib:format("~p", [Value]);
lexical_cast(Value, to, "integer") when is_integer(Value) ->
    Value.   
