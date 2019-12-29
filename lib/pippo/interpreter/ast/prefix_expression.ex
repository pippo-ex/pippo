defmodule Pippo.Interpreter.Ast.PrefixExpression do
  alias Pippo.Interpreter.Ast.Node

  @enforce_keys [:token, :operator, :right]
  defstruct [:token, :operator, :right]

  defimpl Node, for: __MODULE__ do
    def token_literal(expression), do: expression.token.literal

    def node_type(_), do: :expression

    def to_string(expression) do
      operator = expression.operator
      right = Node.to_string(expression.right)
      "(#{operator}#{right})"
    end
  end
end
