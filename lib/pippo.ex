defmodule Pippo do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      Plug.Cowboy.child_spec(scheme: :http, plug: Pippo.Server, options: [
        port: Application.get_env(:pippo, :server_port)
      ]),
      # Pippo.Flow
    ]

    options = [strategy: :one_for_one, name: Pippo.Supervisor]
    Supervisor.start_link(children, options)
  end
end
