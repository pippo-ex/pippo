defmodule Pippo.Consumer do
  @callback deal(any) :: any
  @schemeMap Application.get_env(:pippo, :consumers)

  defmacro __using__(_opts) do
    quote do
      @behaviour Pippo.Consumer
    end
  end

  def deal(type, data) do
    case @schemeMap[type] do
      consumers when is_list(consumers) ->
        Enum.map(consumers, fn (consumer) ->
          consumer.deal(data)
        end)
      nil ->
        IO.puts("unknown scheme: #{type}")
      consumer ->
        consumer.deal(data)
    end
  end
end
