defmodule Pippo.DB do
  use GenServer

  def init(opts) do
    {:ok, opts}
  end
end
