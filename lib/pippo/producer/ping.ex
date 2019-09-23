defmodule Pippo.Producer.Ping do
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, :the_state_doesnt_matter, name: __MODULE__)
  end

  def init(state) do
    {:producer, state, dispatcher: GenStage.BroadcastDispatcher}
  end

  def handle_demand(_demand, state) do
    {:noreply, ["pong"], state}
  end
end
