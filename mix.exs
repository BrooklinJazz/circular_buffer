defmodule Enbala.MixProject do
  use Mix.Project

  def project do
    [
      app: :enbala,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end

  defp deps do
    [{:benchee, "~> 1.0", only: :test}]
  end
end
