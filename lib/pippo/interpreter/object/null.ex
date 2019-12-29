defmodule Pippo.Interpreter.Object.Null do
  alias Pippo.Interpreter.Object.Object

  defstruct []

  defimpl Object, for: __MODULE__ do
    def type(_), do: "NULL"

    def inspect(_), do: "nil"
  end
end
