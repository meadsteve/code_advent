defmodule CodeAdvent.DayEleven.PartOne do
  alias CodeAdvent.DayEleven.Validator

  def run() do
    get_next("hxbxwxba")
  end

  def get_next(previous) do
    candidate = increment(previous)
    if (Validator.valid?(candidate)) do
      candidate
    else
      get_next(candidate)
    end
  end

  def increment(string) do
    string
      |> String.to_char_list
      |> Enum.reverse
      |> increment_char_list
      |> Enum.reverse
      |> to_string
  end

  defp increment_char_list(chars) do
    increment_char_list(chars, [])
  end

  defp increment_char_list([?z | rest], prepend) do
    increment_char_list(rest, ['a' | prepend])
  end

  defp increment_char_list([last | rest], prepend) do
    prepend
      |> Enum.reverse
      |> Enum.concat([last + 1 | rest])
  end

end
