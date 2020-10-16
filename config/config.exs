use Mix.Config

config :pippo, server_port: 4000

config :pippo, producers: [
  {Pippo.Producer.PingTest, %{source: "web_hook", scheme: "/ping_test"}},
]

config :pippo, consumers: %{
  "ping_test" => Pippo.Handler.PingTest,
  "http_response" => Pippo.Consumer.HttpResponse,
}
