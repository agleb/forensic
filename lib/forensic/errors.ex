defmodule Forensic.Errors do
  defstruct history: []

  @type t :: %Forensic.Errors{
          history: [%Forensic.Error{}]
        }

  @spec new(any(), any(), any(), any(), any()) :: Forensic.Errors.t()
  def new(description, module, function, bindings, contents) do
    %Forensic.Errors{
      history: [Forensic.Error.new(description, module, function, bindings, contents)]
    }
  end

  @spec add(Forensic.Errors.t(), any(), any(), any(), any(), any()) :: [...]
  def add(%Forensic.Errors{} = errors, description, module, function, bindings, contents) do
    %Forensic.Errors{
      history:
        List.insert_at(
          errors.history,
          0,
          Forensic.Error.new(description, module, function, bindings, contents)
        )
    }
  end
end
