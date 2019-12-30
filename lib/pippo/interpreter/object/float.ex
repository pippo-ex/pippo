defmodule Pippo.Interpreter.Object.Float do
  alias Pippo.Interpreter.Object.{Hash, Object}

  @enforce_keys [:value]
  defstruct [:value]

  defimpl Object, for: __MODULE__ do
    def type(_), do: "FLOAT"

    def inspect(obj), do: Float.to_string(obj.value)
  end

  defimpl Hash.Hashable, for: __MODULE__ do
    def hash(obj) do
      %Hash.Key{type: Object.type(obj), value: obj.value}
    end
  end
end
