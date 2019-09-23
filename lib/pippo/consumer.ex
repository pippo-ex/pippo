defmodule Pippo.Consumer do
  defmacro get_subscriptions do
    quote do
      Application.get_env(:pippo, :flow)
      |> Enum.filter(fn {_, consumer} -> consumer == __MODULE__ end)
      |> Enum.map(fn {producer, _} -> producer end)
    end
  end
end
