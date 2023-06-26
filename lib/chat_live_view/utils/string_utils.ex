defmodule Utils.StringUtils do
  @moduledoc false

  @spec capitalize(String.t()) :: String.t()
  def capitalize(<<first::utf8, rest::binary>>) do
    <<first::utf8>>
    |> String.trim()
    |> String.upcase()
    |> then(&"#{&1}#{String.trim(rest)}")
  end

  @spec capitalize_all(String.t()) :: String.t()
  def capitalize_all(terms) do
    terms
    |> String.split(" ")
    |> Stream.map(&capitalize/1)
    |> Enum.join(" ")
  end
end
