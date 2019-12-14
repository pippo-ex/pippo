defmodule Pippo.Interpreter.Object.Error do
  alias Pippo.Interpreter.Object.Object

  @enforce_keys [:message]
  defstruct [:message]

  defimpl Object, for: __MODULE__ do
    def type(_), do: "ERROR"

    def inspect(obj), do: "ERROR: #{obj.message}"
  end
end
