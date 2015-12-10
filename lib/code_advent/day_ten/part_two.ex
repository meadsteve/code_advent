defmodule CodeAdvent.DayTen.PartTwo do

  def run() do
    "3113322113"
      |> CodeAdvent.DayTen.PartOne.run(times: 50)
      |> String.length
      |> as_string
  end

  defp as_string(number), do: "#{number}"
end
