defmodule Forensic do
  @moduledoc """
  Simple macro for reporting pass-through errors in Elixir
  """

  defmacro error(error, description \\ :no_description, contents \\ nil) do
    quote do
      vars = Keyword.delete(binding(), :error)
      cast = __ENV__
      {function_name, arity} = cast.function

      case unquote(error) do
        {:error, %Forensic.Errors{} = errors} ->
          {:error,
           Forensic.Errors.add(
             errors,
             unquote(description),
             __MODULE__,
             Atom.to_string(function_name) <> "/" <> to_string(arity),
             vars,
             unquote(contents)
           )}

        {:error, the_error} ->
          {:error,
           Forensic.Errors.new(
             unquote(description),
             __MODULE__,
             Atom.to_string(function_name) <> "/" <> to_string(arity),
             vars,
             the_error
           )}

        error ->
          {:error,
           Forensic.Errors.new(
             unquote(description),
             __MODULE__,
             Atom.to_string(function_name) <> "/" <> to_string(arity),
             vars,
             unquote(error)
           )}
      end
    end
  end
end
