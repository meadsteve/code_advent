defmodule CodeAdvent.DayFive.PartOne do
  @file_path "lib/code_advent/day_five/input_data.txt"

  @vowels ["a", "e", "i", "o", "u"]

  def run() do
    @file_path
      |> File.read!
      |> run
  end

  def run (string) do
    string
    |> String.split
    |> Stream.map(&String.graphemes/1)
    |> Stream.filter(&has_three_vowels?/1)
    |> Stream.filter(&has_double_letter?/1)
    |> Stream.filter(fn letters -> !has_bad_pair?(letters) end)
    |> Enum.count
    |> answer_as_string
  end

  defp has_three_vowels?(letters) do
    vowels = letters
      |> Stream.filter(&is_vowel?/1)
      |> Enum.count
    vowels >= 3
  end

  defp is_vowel?(letter) do
    @vowels |> Enum.member?(letter)
  end

  defp has_double_letter?([]), do: false
  defp has_double_letter?([x, x | _]), do: true
  defp has_double_letter?([_y | remaining]), do: has_double_letter?(remaining)

  defp has_bad_pair?([]), do: false
  defp has_bad_pair?(["a", "b" | _]), do: true
  defp has_bad_pair?(["c", "d" | _]), do: true
  defp has_bad_pair?(["p", "q" | _]), do: true
  defp has_bad_pair?(["x", "y" | _]), do: true
  defp has_bad_pair?([_y | remaining]), do: has_bad_pair?(remaining)


  defp answer_as_string(number), do: "#{number}"
end
