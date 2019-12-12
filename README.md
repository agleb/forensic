# Forensic

[![Hex.pm](https://img.shields.io/hexpm/v/forensic.svg)](https://hex.pm/packages/forensic)

Handling monads `{:ok, result}` and `{:error, description}` can be very tricky in a complex systems.
Moreover, it is very difficult to track the history of the error and it's influence. Unfortunately there are no built-in tools for that.

Forensic is pass-through error protocol and a set of macros, aimed to sctructurally register the description of the error in the context, where it had occured and collect all the collateral errors.

Forensic's protocol fully follows `{:error, description}` ideology.

`Forensic.error(error, description \\ :no_description, contents \\ nil)` will transparently incapsulate all {:error, description} or even any arbitary error given.

## Installation

```elixir
def deps do
  [
    {:forensic, "~> 0.2.2"}
  ]
end
```
## Concept

`Forensic.error(...)` returns the error tuple in the format:

```elixir
{:error,
       %Forensic.Errors{
         history: [
           %Forensic.Error{
             bindings: [],
             contents: nil,
             description: :no_description,
             function: "test Forensic.Errors protocol detection/1",
             module: ForensicTest
           },
           %Forensic.Error{
             bindings: [],
             contents: nil,
             description: :no_description,
             function: "test Forensic.Errors protocol detection/1",
             module: ForensicTest
           }
         ]
       }}
```

## Usage

Basic scenario

```elixir

import Forensic

...

Forensic.error(error_to_describe)

...
```

The full-on scenario is:

```elixir
import Forensic

def Foo(some_var) do
  with {:ok, result} <- Foo2(some_var) do
    {:ok, result}
  else
    Forensic.last?(:error_signature) -> do_something_for_this_error_signature()
    Forensic.last?(:error_signature_2) = error -> do_something_for_this_error_signature2()
                                                  # Register unrecoverable error afterwards
                                                  Forensic.error(error, :error_description2)
    error -> Forensic.error(error, :error_description)
  end
end
```

`Forensic.last?(error)` extracts the last error description from like was in `{:error, description}` providing a way to handle different errors by their signatures as well.


## License

MIT



