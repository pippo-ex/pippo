defmodule Pippo.Producer.PingTest do
  import Plug.Conn
  use Pippo.Producer

  def call(conn) do
    conn = send_chunked(conn, 200)
    broadcast("ping_test", conn)
    conn
  end
end
