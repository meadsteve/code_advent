defmodule CodeAdvent.DayEleven.Validator do

  @bad_chars [?i, ?o, ?l]

  def valid?(string) do
    chars = String.to_char_list(string)

    has_sequence?(chars)
    && !contains_bad_chars?(chars)
    && has_two_pairs?(chars)
  end

  def has_sequence?([x, y, z | _rest]) when y == x + 1 and z == x + 2, do: true
  def has_sequence?([_x | rest]), do: has_sequence?(rest)
  def has_sequence?(_), do: false

  def contains_bad_chars?(chars) do
    @bad_chars
      |> Stream.map(fn bad_char -> contains_char?(chars, bad_char) end)
      |> Enum.member?(true)
  end

  defp contains_char?([char | _ ], char), do: true
  defp contains_char?([_ | rest ], char), do: contains_char?(rest, char)
  defp contains_char?([], char), do: false

  def has_two_pairs?(chars) do
    pairs = chars
      |> get_unique_pairs()
      |> Enum.count
    pairs >= 2
  end

  defp get_unique_pairs(chars), do: get_unique_pairs(chars, [])

  defp get_unique_pairs([], paired_letters) do
    Enum.uniq(paired_letters)
  end

  defp get_unique_pairs([x, x | rest], paired_letters) do
    get_unique_pairs(rest, [x | paired_letters])
  end

  defp get_unique_pairs([_z | rest], paired_letters) do
    get_unique_pairs(rest, paired_letters)
  end

end
