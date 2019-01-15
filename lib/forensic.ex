defmodule Forensic do
  @moduledoc """
  Simple macro for reporting pass-through errors in Elixir
  """

  defmacro error(error) do
    quote do
      vars = binding()
      cast = __ENV__
      {function_name, arity} = cast.function

      {:error,
       {__MODULE__, Atom.to_string(function_name) <> "/" <> to_string(arity), vars,
        unquote(error)}}
    end
  end
end
