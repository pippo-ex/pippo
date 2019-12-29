defmodule Pippo.Interpreter.Evaluator.Builtins do
  alias Pippo.Interpreter.Object.{
    Builtin,
    Error,
    Object,
    String,
  }

  def get("typeof"), do: %Builtin{fn: &typeof/1}
  def get(_), do: nil

  def typeof([arg] = args) when length(args) == 1 do
    %String{value: Object.type(arg)}
  end
  def typeof(args), do: error("wrong number of arguments. got=#{length(args)}, want=1")

  defp error(message), do: %Error{message: message}
end
