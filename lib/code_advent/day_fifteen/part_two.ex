defmodule CodeAdvent.DayFifteen.PartTwo do
  @file_path "lib/code_advent/day_fifteen/input_data.txt"

  alias CodeAdvent.DayFifteen.PartOne

  def run() do
    [i1, i2, i3, i4] = @file_path
      |> File.read!
      |> String.split("\n", trim: true)
      |> Enum.map(&PartOne.parse/1)

    combinations = for c1 <- 0..100,
        c2 <- 0..100,
        c3 <- 0..100,
        c4 <- 0..100,
        c1 + c2 + c3 + c4 == 100,
        list = [{c1, i1}, {c2, i2}, {c3, i3}, {c4, i4}],
        calories(list) == 500
    do
      {PartOne.score(list), list}
    end

    [winner | _] = combinations
      |> Enum.sort(fn ({a, _},{b, _}) -> a > b end)

    winner |> as_string
  end

  def calories(items) do
    PartOne.score_for(items, :calories)
  end

  defp as_string({n, _}), do: "#{n}"
end
