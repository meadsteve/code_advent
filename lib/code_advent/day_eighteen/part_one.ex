defmodule CodeAdvent.DayEighteen.PartTwo do
  alias CodeAdvent.DayEighteen.Grid
  alias CodeAdvent.DayEighteen.Parser
  alias CodeAdvent.DayEighteen.Runner

  @file_path "lib/code_advent/day_eighteen/input_data.txt"

  def run() do
    grid = @file_path
      |> File.read!
      |> Parser.parse
      |> Grid.stick_on(0, 0)
      |> Grid.stick_on(0, 99)
      |> Grid.stick_on(99, 0)
      |> Grid.stick_on(99, 99)

    1..100
      |> Enum.reduce(grid, fn(_, new_grid) -> Runner.next(new_grid) end)
      |> Grid.light_count
      |> as_string
  end

  defp as_string(n), do: "#{n}"
end
