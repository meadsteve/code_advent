defmodule CodeAdvent.DayOne.PartOne do
  @file_path "lib/code_advent/day_one/input_data.txt"

  def run() do
    @file_path
      |> File.read!
      |> String.graphemes
      |> Enum.map(&instruction_to_floor_change/1)
      |> Enum.sum
      |> answer_as_string
  end

  defp instruction_to_floor_change("("), do: 1
  defp instruction_to_floor_change(")"), do: -1
  defp instruction_to_floor_change(_), do: 0

  defp answer_as_string(number), do: "#{number}"
end
