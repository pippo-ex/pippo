defmodule Pippo.Interpreter.Evaluator.Builtins do
  alias Pippo.Interpreter.Object.Builtin

  def get("get_version"), do: %Builtin{fn: &get_version/1}
  def get(_), do: nil

  def get_version(_args) do
    "unknown"
  end
end
