defmodule Pippo.Interpreter.Ast.BlockStatement do
  alias Pippo.Interpreter.Ast.Node

  @enforce_keys [:token, :statements]
  defstruct [:token, :statements]

  defimpl Node, for: __MODULE__ do
    def token_literal(expression), do: expression.token.literal

    def node_type(_), do: :expression

    def to_string(expression) do
      expression.statements
      |> Enum.map(&Node.to_string/1)
      |> Enum.join()
    end
  end
end
