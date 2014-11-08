yep language
===

yaml-erlang-python language

## Goals
1. Code must be valid YAML
1. Code must translate to Erlang
1. This is a Functional language, not imperative.
1. convention over configuration.
1. definition/declaration all in one.
   1. No header files.  
   1. optional type specifications must be in-line
1. No "import" or "include" statements.  
   1. No separate "export" statements necessary (see above).  
   2. All functions are public and exported (unless they begin with _)  
   3. To reference `function` in `path/to/module.yep` simply say: `path:to:module:function(Args...)`
1. copy/paste-friendly, i.e. no commas or periods required.  Lists/Tuple elements separated by space only.  expressions separated with newlines only
1. first-class string objects enclosed by double-quotes.  They get translated to erlang binaries.
1. Must be able to have valid erlang expressions inside the yaml.
1. Python style comments

## Examples:
1. sample.yep:

    ```yaml
    lexical cast Value::integer to "string":
    - io_lib:format("~p", [Value])
    lexical cast Value::integer to "integer":
    - Value
    ```
   
    generates `sample.erl`:
   
    ```erlang
    -module(sample).
    -export([lexical_cast]).
    -spec lexical_cast(Value::integer, Type::string) -> ReturnType.
    lexical_cast(Value, to, "string") when is_integer(Value) ->
        io_lib:format("~p", [Value]);
    lexical_cast(Value, to, "integer") when is_integer(Value) ->
        Value.   
    ```
