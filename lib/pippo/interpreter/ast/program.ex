defmodule Pippo.Interpreter.Ast.Program do
  alias Pippo.Interpreter.Ast.Node

  @enforce_keys [:statements]
  defstruct [:statements]

  def token_literal(program) do
    if length(program.statements) > 0 do
      program.statements
      |> List.first()
      |> Node.token_literal()
    else
      ""
    end
  end

  def to_string(program) do
    program.statements
    |> Enum.map(&Node.to_string/1)
    |> Enum.join()
  end
end
