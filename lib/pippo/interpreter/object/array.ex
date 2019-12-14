defmodule Pippo.Interpreter.Object.Array do
  alias Pippo.Interpreter.Object.Object

  @enforce_keys [:elements]
  defstruct [:elements]

  defimpl Object, for: __MODULE__ do
    def type(_), do: "ARRAY"

    def inspect(obj) do
      elements =
        obj.elements
        |> Enum.map(&Object.inspect/1)
        |> Enum.join(", ")

      "[#{elements}]"
    end
  end
end
