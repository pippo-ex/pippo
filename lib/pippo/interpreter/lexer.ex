defmodule Pippo.Interpreter.Lexer do
  import Pippo.Interpreter.Qualifier
  alias Pippo.Interpreter.Token

  def tokenize(input) do
    tokenize(String.trim(input), [])
  end

  defp tokenize("", tokens) do
    Enum.reverse([Token.new(type: :eof, literal: "") | tokens])
  end
  defp tokenize("==" <> rest, tokens) do
    tokenize(rest, [%Token{type: :eq, literal: "=="} | tokens])
  end
  defp tokenize("!=" <> rest, tokens) do
    tokenize(rest, [%Token{type: :not_eq, literal: "!="} | tokens])
  end
  defp tokenize(<<ch::binary-size(1), rest::binary>>, tokens) when is_whitespace(ch) do
    tokenize(rest, tokens)
  end
  defp tokenize(<<ch::binary-size(1), _::binary>> = chars, tokens) when is_letter(ch) do
    read_identifier(chars, tokens)
  end
  defp tokenize(<<ch::binary-size(1), _::binary>> = chars, tokens) when is_digit(ch) do
    read_number(chars, tokens)
  end
  defp tokenize(<<ch::binary-size(1), _::binary>> = chars, tokens) when is_quote(ch) do
    read_string(chars, tokens)
  end
  defp tokenize(chars, tokens) do
    read_next_char(chars, tokens)
  end

  defp read_identifier(chars, tokens) do
    {identifier, rest} = read_sequence(chars, &(is_letter(&1) or is_digit(&1)))
    token = Token.new(type: Token.lookup_ident(identifier), literal: identifier)

    tokenize(rest, [token | tokens])
  end

  defp read_number(chars, tokens) do
    {number, rest} = read_sequence(chars, &is_digit/1)
    token = Token.new(type: :int, literal: number)

    tokenize(rest, [token | tokens])
  end

  defp read_string("\"" <> rest, tokens) do
    {string, "\"" <> rest} = read_sequence(rest,  &(!is_quote(&1)))
    token = Token.new(type: :string, literal: string)

    tokenize(rest, [token | tokens])
  end

  defp read_next_char(<<ch::binary-size(1), rest::binary>>, tokens) do
    token =
      case ch do
        "=" -> Token.new(type: :assign, literal: ch)
        ";" -> Token.new(type: :semicolon, literal: ch)
        ":" -> Token.new(type: :colon, literal: ch)
        "(" -> Token.new(type: :lparen, literal: ch)
        ")" -> Token.new(type: :rparen, literal: ch)
        "+" -> Token.new(type: :plus, literal: ch)
        "-" -> Token.new(type: :minus, literal: ch)
        "!" -> Token.new(type: :bang, literal: ch)
        "*" -> Token.new(type: :asterisk, literal: ch)
        "/" -> Token.new(type: :slash, literal: ch)
        "<" -> Token.new(type: :lt, literal: ch)
        ">" -> Token.new(type: :gt, literal: ch)
        "," -> Token.new(type: :comma, literal: ch)
        "{" -> Token.new(type: :lbrace, literal: ch)
        "}" -> Token.new(type: :rbrace, literal: ch)
        "[" -> Token.new(type: :lbracket, literal: ch)
        "]" -> Token.new(type: :rbracket, literal: ch)
        _ -> Token.new(type: :illegal, literal: ch)
      end

    tokenize(rest, [token | tokens])
  end

  defp read_sequence(input, fun, acc \\ "")
  defp read_sequence("", _, acc), do: {acc, ""}
  defp read_sequence(<<ch::binary-size(1), rest::binary>> = chars, fun, acc) do
    if fun.(ch) do
      read_sequence(rest, fun, acc <> ch)
    else
      {acc, chars}
    end
  end
end
