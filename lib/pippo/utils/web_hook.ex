defmodule Pippo.Utils.WebHook do
  defmacro __using__(_opts) do
    quote do
      def fetch_body(conn, recv \\ "") do
        case read_body(conn) do
          {:ok, body, _} -> recv <> body
          {:more, body, conn} -> fetch_body(conn, recv <> body)
        end
      end
    end
  end
end
