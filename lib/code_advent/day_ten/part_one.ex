defmodule CodeAdvent.DayTen.PartOne do

  def run() do
    "3113322113"
      |> run(times: 40)
      |> String.length
      |> as_string
  end

  def run(string, times: 0), do: string
  def run(string, times: t) do
    string
      |> convert()
      |> run(times: t - 1)
  end

  def convert(number_string) do
    number_string
      |> String.graphemes
      |> convert(1, "")
  end

  defp convert([], _, output), do: output

  defp convert([n, n | rest], count, output) do
    convert([n | rest], count + 1, output)
  end

  defp convert([n | rest], count, output) do
    convert(rest, 1, output <> as_string(count) <> n)
  end

  defp as_string(number), do: "#{number}"
end
