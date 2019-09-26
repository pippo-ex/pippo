defmodule Pippo.WebHook.Ping do
  import Plug.Conn

  def call(conn) do
    Pippo.Producer.Ping.add_task({:web_hook, conn})
    send_resp(conn, 200, "ok")
  end
end
