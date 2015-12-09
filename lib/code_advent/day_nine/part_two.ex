defmodule CodeAdvent.DayNine.PartTwo do
  @file_path "lib/code_advent/day_nine/input_data.txt"

  def run() do
    [best_destination] = @file_path
      |> File.read!
      |> String.split("\n", trim: true)
      |> CodeAdvent.DayNine.PartOne.run
      |> Enum.sort(fn({a,_}, {b,_}) -> a > b end)
      |> Enum.take(1)

    answer_as_string(best_destination)
  end

  defp answer_as_string(thing), do: "#{inspect thing}"

end
