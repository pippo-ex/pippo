defmodule Pippo.MixProject do
  use Mix.Project

  def project do
    [
      app: :pippo,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Pippo, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 2.7"},
      #{:eleveldb, "~> 2.2"},
      {:gen_stage, "~> 0.14"},
      {:plug, "~> 1.8"},
      {:plug_cowboy, "~> 2.1"}
    ]
  end
end
