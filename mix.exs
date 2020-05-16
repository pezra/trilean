defmodule Trinary.Mixfile do
  use Mix.Project

  def project do
    [
      app: :trilean,
      description: "K3+ three-value logic",
      version: "1.0.1",
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
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
      {:dialyxir, "~> 0.3", only: :dev, runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp package do
    [
      licenses: ["http://opensource.org/licenses/MIT"],
      maintainers: ["Peter Williams"],
      links: %{homepage: "http://github.com/pezra/trilean"}
    ]
  end
end
