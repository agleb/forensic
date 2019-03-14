defmodule Forensic.MixProject do
  use Mix.Project

  def project do
    [
      app: :forensic,
      version: "0.2.2",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      deps: deps(),
      name: "Forensic",
      source_url: "https://github.com/agleb/forensic"
    ]
  end

  def application do
    [
      extra_applications: []
    ]
  end

  defp deps do
    [{:ex_doc, "~> 0.14", only: :dev}]
  end

  defp description() do
    "A macro for descriptive error reporting."
  end

  defp package() do
    [
      name: "forensic",
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Gleb Andreev"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/agleb/forensic"}
    ]
  end
end
