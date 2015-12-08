defmodule CodeAdvent.DayEight.PartOne do
  @file_path "lib/code_advent/day_eight/input_data.txt"

  def run() do
    @file_path
      |> File.read!
      |> String.split
      |> run
      |> answer_as_string
  end

  def run(strings) do
    strings
      |> Enum.map(&lengths/1)
      |> Enum.reduce(0, &calc_sum/2)
  end

  defp lengths(string) do
    {String.length(string), memory_length(String.graphemes(string))}
  end

  defp memory_length(["\"" | remaining]) do
    memory_length(remaining, 0)
  end

  defp memory_length(["\""], length), do: length

  defp memory_length(["\\", "\\" | remaining], length) do
    memory_length(remaining, length + 1)
  end

  defp memory_length(["\\", "\"" | remaining], length) do
    memory_length(remaining, length + 1)
  end

  defp memory_length(["\\", "x", _, _ | remaining], length) do
    memory_length(remaining, length + 1)
  end

  defp memory_length([_ | remaining], length) do
    memory_length(remaining, length + 1)
  end

  def calc_sum({file, memory}, total) do
    total + file - memory
  end

  defp answer_as_string(thing), do: "#{inspect thing}"
end
