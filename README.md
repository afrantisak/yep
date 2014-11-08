yep language
===

yaml-erlang-python language

## Usage:

    ```sh
    make
    make install # optional, installs to /usr/local/bin
    ./yep sample1.yep
    ```

## Why?

1. I like Erlang.
1. I don't like messing around with commas and periods when I copy/paste code.
1. I don't like having to keep `-module`, `-export` and `-spec` directives in sync with changing code.
1. I also like YAML and Python.

Basically I want to write Erlang code but I don't want to deal with any of the manual reconciliation fluff that gets in the way.
So this is a simple translation unit that hides the fluff.

## Goals
1. Yep code must be valid YAML.  Why?  Because I thought it would be cool and I don't know how to write a low-level parser.
1. Yep code must be copy/paste-friendly, i.e. no commas or periods required.  Lists/Tuple elements separated by space only.  Expressions separated with newlines only.
1. Code must translate to Erlang.  All valid Erlang expressions are allowed, minus the commas and periods and function declarations.
1. No importing or exporting.  Yep should figure it out for you.
   1. No separate "export" statements necessary.
   2. All functions are public and exported unless they begin with _  
   3. To reference `function` in `path/to/module.yep` simply say: `path:to:module:function(Args...)`
1. optional type specifications must be in-line, no separate -spec directives.
1. first-class string objects enclosed by double-quotes.  They get translated to erlang binaries.

## Examples:
1. sample.yep:

    ```yaml
    lexical cast Value::integer to "string":
    - io_lib:format("~p", [Value])
    lexical cast Value::integer to "integer":
    - Value
    ```
   
    generates `sample.erl`:

    ```sh
    ./yep sample1.yep
    ```
   
    ```erlang
    -module(sample).
    -export([lexical_cast]).

    -spec lexical_cast(Value::integer, Type::string) -> ReturnType.
    lexical_cast(Value, to, "string") when is_integer(Value) ->
        io_lib:format("~p", [Value]);
    lexical_cast(Value, to, "integer") when is_integer(Value) ->
        Value.   
    ```
