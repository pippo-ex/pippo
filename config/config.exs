use Mix.Config

config :pippo, server_port: 4000

config :pippo, web_hooks: [
  {Pippo.WebHook.Ping, "/ping", []},
]

config :pippo, producers: [
  {Pippo.Producer.Ping, []}
]

config :pippo, consumers: [
  {Pippo.Consumer.ConsoleInspector, []},
  {Pippo.Consumer.ConsoleLogger, []},
]

config :pippo, flow: [
  {Pippo.WebHook.Ping, Pippo.Consumer.ConsoleLogger},
  {Pippo.WebHook.Ping, Pippo.Consumer.ConsoleInspector},
]
