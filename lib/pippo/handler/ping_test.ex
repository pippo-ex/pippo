defmodule Pippo.Handler.PingTest do
  use Pippo.Consumer
  use Pippo.Producer

  def deal(data) do
    broadcast("http_response", %{
      "conn" => data,
      "message" => "pong"
    })
  end
end
