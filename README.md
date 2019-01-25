# Forensic

[![Hex.pm](https://img.shields.io/hexpm/v/forensic.svg)](https://hex.pm/packages/forensic)

Forensic.error is a macro, which returns the description of the error in the context, where it had occured.

## Installation

```elixir
def deps do
  [
    {:forensic, "~> 0.1.0"}
  ]
end
```
## Concept

Return the error tuple in the format:

{:error, {\_\_MODULE\_\_, \_\_ENV_\_.function, vars, error}}

## Usage

```elixir

require Forensic

...

Forensic.error(error_to_describe)

...
```

## License

MIT. Do what you want.



