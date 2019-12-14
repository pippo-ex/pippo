defmodule Pippo.Interpreter.Object.ReturnValue do
  alias Pippo.Interpreter.Object.Object

  @enforce_keys [:value]
  defstruct [:value]

  defimpl Object, for: __MODULE__ do
    def type(_), do: "RETURN_VALUE"

    def inspect(obj), do: Object.inspect(obj.value)
  end
end
