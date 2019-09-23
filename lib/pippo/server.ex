defmodule Pippo.Server do
  use Plug.Router
  use Plug.ErrorHandler

  plug :match
  plug :dispatch

  for {mod, scope, _} <- Application.get_env(:pippo, :web_hooks) do
    match scope do
      unquote(mod).call(conn)
    end
  end

  match _ do
    send_resp(conn, 404, "oops")
  end

  def handle_errors(conn, %{kind: _kind, reason: reason, stack: _stack}) do
    send_resp(conn, conn.status, "error: " <> reason)
  end
end
