defmodule Pippo.WebHook.Ping do
  import Plug.Conn
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(state) do
    {:producer_consumer, state, dispatcher: GenStage.BroadcastDispatcher, subscribe_to: [Pippo.Producer.Ping]}
  end

  def call(conn) do
    GenServer.cast(__MODULE__, {:ask})
    send_resp(conn, 200, "ok")
  end

  def handle_subscribe(:producer, _options, from, state) do
    {:manual, Map.put(state, :producer, from)}
  end

  def handle_subscribe(:consumer, _, _, state) do
    {:automatic, state}
  end

  def handle_events(events, _from, state) do
    {:noreply, events, state}
  end

  def handle_cast({:ask}, state) do
    GenStage.ask(state.producer, 1)
    {:noreply, [], state}
  end
end
