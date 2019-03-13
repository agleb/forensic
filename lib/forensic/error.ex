defmodule Forensic.Error do
  defstruct description: nil, module: nil, function: nil, bindings: nil, contents: nil

  @type t :: %Forensic.Error{
          description: any,
          module: any,
          function: any,
          bindings: any,
          contents: any
        }

  @spec new(any(), any(), any(), any(), any()) :: Forensic.Error.t()
  def new(description, module, function, bindings, contents) do
    %Forensic.Error{
      description: description,
      module: module,
      function: function,
      bindings: bindings,
      contents: contents
    }
  end
end
