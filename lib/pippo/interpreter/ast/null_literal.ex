defmodule Pippo.Interpreter.Ast.NullLiteral do
  alias Pippo.Interpreter.Ast.Node

  @enforce_keys [:token]
  defstruct [:token]

  defimpl Node, for: __MODULE__ do
    def token_literal(literal), do: literal.token.literal

    def node_type(_), do: :expression

    def to_string(_), do: "NULL"
  end
end
