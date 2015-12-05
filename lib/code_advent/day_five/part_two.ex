defmodule CodeAdvent.DayFive.PartTwo do
  @file_path "lib/code_advent/day_five/input_data.txt"


  def run() do
    @file_path
      |> File.read!
      |> run
  end

  def run (string) do
    string
    |> String.split
    |> Stream.map(&String.graphemes/1)
    |> Stream.filter(&has_double_pair?/1)
    |> Stream.filter(&has_double_with_gap?/1)
    |> Enum.count
    |> answer_as_string
  end


  defp has_double_with_gap?([]), do: false
  defp has_double_with_gap?([x, _y, x | _]), do: true
  defp has_double_with_gap?([_z | remaining]), do: has_double_with_gap?(remaining)

  defp has_double_pair?([]), do: false
  defp has_double_pair?([_]), do: false
  defp has_double_pair?([x, y | rest]) do
    if rest |> contains_pair?(x, y) do
      true
    else
      has_double_pair?([y | rest])
    end
  end

  defp contains_pair?([], _, _), do: false
  defp contains_pair?([_], _, _), do: false
  defp contains_pair?([x, y | _rest], x, y), do: true
  defp contains_pair?([z | rest], x, y), do: contains_pair?(rest, x, y)

  defp answer_as_string(number), do: "#{number}"
end
