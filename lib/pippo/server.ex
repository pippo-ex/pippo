defmodule Pippo.Server do
  use Plug.Router
  use Plug.ErrorHandler

  plug :match
  plug :dispatch

  for {mod, reg} <- Application.get_env(:pippo, :producers) do
    case reg do
      %{source: "web_hook", scheme: scheme} ->
        match scheme do
          unquote(mod).call(conn)
        end
    end
  end

  match _ do
    send_resp(conn, 404, "oops")
  end

  def handle_errors(conn, %{kind: _kind, reason: reason, stack: _stack}) do
    send_resp(conn, conn.status, "error: " <> reason)
  end
end
