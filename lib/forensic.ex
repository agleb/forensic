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
             the_error,
             __MODULE__,
             Atom.to_string(function_name) <> "/" <> to_string(arity),
             vars,
             unquote(description)
           )}

        error ->
          {:error,
           Forensic.Errors.new(
             unquote(error),
             __MODULE__,
             Atom.to_string(function_name) <> "/" <> to_string(arity),
             vars,
             unquote(description)
           )}
      end
    end
  end

  defmacro last?(error_signature) do
    quote do
      {:error,
       %Forensic.Errors{history: [%Forensic.Error{description: unquote(error_signature)} | _]}}
    end
  end
end
