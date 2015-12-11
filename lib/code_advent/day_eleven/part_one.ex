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

  defp increment_char_list([?z | rest]) do
    # ++ is slow but yolo
    'a' ++ increment_char_list(rest)
  end

  defp increment_char_list([last | rest]) do
    [last + 1 | rest]
  end
  
end
