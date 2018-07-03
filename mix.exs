defmodule Observable.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :observable,
      version: @version,
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env()),
      description: description(),
      package: package(),
      start_permanent: Mix.env() == :prod,
      name: "Ecto.Observable",
      docs: docs(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test) do
    ["lib", "test/support"]
  end

  defp elixirc_paths(_) do
    ["lib"]
  end

  defp description do
    """
    Provides simple tools to implement the "Observer" pattern.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Nicholas Sweeting"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/nsweeting/observable"}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"],
      source_url: "https://github.com/nsweeting/observable"
    ]
  end

  defp deps do
    []
  end
end
