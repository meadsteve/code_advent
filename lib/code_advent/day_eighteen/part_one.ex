defmodule CodeAdvent.DayEighteen.PartOne do
  alias CodeAdvent.DayEighteen.Grid
  alias CodeAdvent.DayEighteen.Parser
  alias CodeAdvent.DayEighteen.Runner

  @file_path "lib/code_advent/day_eighteen/input_data.txt"

  def run() do
    grid = @file_path
      |> File.read!
      |> Parser.parse
    1..100
      |> Enum.reduce(grid, fn(_, new_grid) -> Runner.next(new_grid) end)
      |> Grid.light_count
      |> as_string
  end

  defp as_string(n), do: "#{n}"
end
