defmodule InsigniaNotify.MixProject do
  use Mix.Project

  def project do
    [
      app: :insignia_notify,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      default_task: "run"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    env = Application.get_env(:insignia_notify, :environment)

    if env == :prod do
      [
        extra_applications: [:logger],
        mod: {InsigniaNotify.Job.Execute, []}
      ]
    else
      [
        extra_applications: [:logger]
      ]
    end
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:floki, "~> 0.34.0"},
      {:httpoison, "~> 2.0"},
      {:poison, "~> 5.0"}
    ]
  end
end
