defmodule Pippo.Producer do
  defmacro __using__(_opts) do
    quote do
      def broadcast(type, data) do
        Pippo.Consumer.deal(type, data)
      end
    end
  end
end
