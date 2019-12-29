defmodule Pippo.Interpreter.Object.String do
  alias Pippo.Interpreter.Object.{Hash, Object}

  @enforce_keys [:value]
  defstruct [:value]

  defimpl Object, for: __MODULE__ do
    def type(_), do: "STRING"

    def inspect(obj), do: "\"#{obj.value}\""
  end

  defimpl Hash.Hashable, for: __MODULE__ do
    def hash(obj) do
      value = :crypto.hash(:md5, obj.value) |> Base.encode16()
      %Hash.Key{type: Object.type(obj), value: value}
    end
  end
end
