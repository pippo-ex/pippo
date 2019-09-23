defmodule Pippo.Flow do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    children =
      Enum.map(Application.get_env(:pippo, :producers), fn {mod, args} -> worker(mod, args) end) ++
      Enum.map(Application.get_env(:pippo, :web_hooks), fn {mod, _, args} -> worker(mod, args) end) ++
      Enum.map(Application.get_env(:pippo, :consumers), fn {mod, args} -> worker(mod, args) end)

    Supervisor.init(children, strategy: :one_for_one)
  end
end
