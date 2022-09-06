defmodule Grimoire.MixProject do
  use Mix.Project

  def project do
    [
      app: :grimoire,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      author: "Bas van Ooyen",
      description: "GraphQL federation first API framework for true warlocks",
      package: package(),
      deps: deps()
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Bas van Ooyen"],
      licenses: ["BSD-2-Clause"],
      links: %{"Github" => "https://github.com/bettybas/grimoire"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:plug, "~> 1.10"},
      {:plug_cowboy, "~> 2.0"},
      {:absinthe_plug, "~> 1.5"},
      {:absinthe_federation, "~> 0.2.53"},
      {:jason, "~> 1.0"}
    ]
  end
end
