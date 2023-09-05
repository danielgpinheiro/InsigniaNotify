defmodule InsigniaNotify.MixProject do
  use Mix.Project

  def project do
    [
      app: :insignia_notify,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:floki, "~> 0.34.0"},
      {:req, "~> 0.3.0"},
      {:req_easyhtml, "~> 0.1.0"},
      {:httpoison, "~> 2.0"}
    ]
  end
end