defmodule CodeAdvent.DayOne.PartTwo do
  @file_path "lib/code_advent/day_one/input_data.txt"

  @target_floor -1

  def run() do
    @file_path
      |> File.read!
      |> String.graphemes
      |> Stream.map(&instruction_to_floor_change/1)
      |> Stream.with_index
      |> Stream.scan({0 , nil}, &update_floor/2)
      |> run_up_to_floor(@target_floor)
      |> extract_answer
  end

  defp instruction_to_floor_change("("), do: 1
  defp instruction_to_floor_change(")"), do: -1
  defp instruction_to_floor_change(_), do: 0

  defp update_floor({change, n}, {previous_floor, _}) do
    {previous_floor + change, n}
  end

  defp run_up_to_floor(stream, floor_target) do
    stream
      |> Stream.take_while(fn {floor, _} -> floor !== floor_target end)
  end

  defp extract_answer(stream) do
    stream
      |> get_last
      |> add_one # index is zero based
      |> add_one # stream stops 1 before the floor is reached
      |> answer_as_string
  end

  defp answer_as_string({_, move_number}), do: "#{move_number}"

  defp add_one({x, n}), do: {x, n + 1}

  defp get_last(stream), do: Enum.reduce(stream, fn(x,_) -> x end)
end
