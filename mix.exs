defmodule Enbala.MixProject do
  use Mix.Project

  def project do
    [
      app: :enbala,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: []
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end
end
