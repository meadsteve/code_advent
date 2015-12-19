defmodule CodeAdvent.DayNineteen.PartTwo do
  alias CodeAdvent.DayNineteen.PartOne

  @file_path "lib/code_advent/day_nineteen/input_data.txt"
  @max_tries 100

  def run() do
    data = @file_path
      |> File.read!
      |> PartOne.parse
      |> iterations_to_find
      |> as_string
  end

  def iterations_to_find(data) do
    [{n, _list}] = 1..@max_tries
      |> Stream.scan({0, "e"}, &generate_molecules(&1, &2, data))
      |> Stream.drop_while(&doesnt_contain_target(&1, data))
      |> Enum.take(1)
    n
  end

  defp generate_molecules(_, {n, starting_points}, data) do
    {n + 1, PartOne.generate_molecules(data, starting_points)}
  end

  defp doesnt_contain_target({_, list}, data) do
    answer = list
      |> Enum.member?(data.goal_string)
    !answer
  end

  defp as_string(n), do: "#{n}"
end
