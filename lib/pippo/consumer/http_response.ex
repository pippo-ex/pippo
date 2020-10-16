defmodule Pippo.Consumer.HttpResponse do
  import Plug.Conn
  use Pippo.Consumer

  def deal(%{"conn" => conn, "message" => message}) do
    chunk(conn, message)
  end
end
