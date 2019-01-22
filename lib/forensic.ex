defmodule Forensic do
  @moduledoc """
  Simple macros for reporting pass-through errors in Elixir
  """

  @doc """
  Attach a record to the error history with vars bindings
  """
  defmacro attach(error) do
    quote do
      vars = binding()
      cast = __ENV__
      {function_name, arity} = cast.function
      error_record = {__MODULE__, Atom.to_string(function_name) <> "/" <> to_string(arity), vars}

      case unquote(error) do
        {:error, contents} when is_list(contents) ->
          {:error, [error_record | contents]}

        {:error, contents} when not is_list(contents) ->
          {:error, [error_record, contents]}

        unrecognized ->
          {:error, [error_record, unrecognized]}
      end
    end
  end

  @doc """
  Return the error from it's context with vars bindings
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
