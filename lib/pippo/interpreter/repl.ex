defmodule Pippo.Interpreter.Repl do
  alias Pippo.Interpreter.Evaluator
  alias Pippo.Interpreter.Lexer
  alias Pippo.Interpreter.Object.{Environment, Object}
  alias Pippo.Interpreter.Parser

  @prompt ">> "

  def loop(env \\ Environment.build()) do
    input = IO.gets(@prompt)
    tokens = Lexer.tokenize(input)
    parser = Parser.from_tokens(tokens)
    {parser, program} = Parser.parse_program(parser)

    case length(parser.errors) do
      0 ->
        {result, env} = Evaluator.eval(program, env)
        case result do
          nil -> nil
          _ -> IO.puts(Object.inspect(result))
        end

        loop(env)

      _ ->
        print_parser_errors(parser.errors)
        loop(env)
    end
  end

  defp print_parser_errors(errors) do
    IO.puts("Parser Errors:")
    Enum.each(errors, &IO.puts/1)
  end
end
