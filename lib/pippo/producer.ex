defmodule Pippo.Producer do
  def dispatch_events(queue, demand, events \\ []) do
    with d when d > 0 <- demand,
      {{:value, event}, queue} <- :queue.out(queue) do
        dispatch_events(queue, demand - 1, [event | events])
    else
      _ -> {:noreply, Enum.reverse(events), {queue, demand}}
    end
  end
end
