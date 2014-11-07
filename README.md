yep language
===

yaml-erlang-python language

## Goals
1. Code must be valid YAML
1. convention over configuration
1. definition/declaration all in one.  No header files.  optional type specifications must be in-line
1. No "import" or "include" statements.  No separate "export" statements necessary (see above).  
   All functions are public and exported.  To reference function in path/to/module.yep simply say: path.to.module.function
1. copy/pastable, i.e. no commas or periods required.  Lists/Tuples separated by space only.
1. first-class string objects - translated to erlang binaries
1. Otherwise must be able to have valid erlang expressions inside the yaml.
1. Functional, not imperative
1. Python style comments

## Examples:
1. sample.yep:
        cast Value::integer to "String" lexical:
        - io_lib:format("~p", [Value])
    sample.erl:
        -spec cast(Value::integer, Type::string) -> ReturnType.
        cast(Value, to, "String", lexical) when is_integer(Value) ->
          io_lib:format("~p", [Value]).
