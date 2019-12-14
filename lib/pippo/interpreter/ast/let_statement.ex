defmodule Pippo.Interpreter.Ast.LetStatement do
  alias Pippo.Interpreter.Ast.Node

  @enforce_keys [:token, :name, :value]
  defstruct [:token, :name, :value]

  defimpl Node, for: __MODULE__ do
    def token_literal(statement), do: statement.token.literal

    def node_type(_), do: :statement

    def to_string(statement) do
      out = [
        Node.token_literal(statement),
        " ",
        Node.to_string(statement.name),
        " = ",
      ]

      out = if statement.value, do: out ++ [Node.to_string(statement.value)], else: out
      Enum.join(out)
    end
  end
end
