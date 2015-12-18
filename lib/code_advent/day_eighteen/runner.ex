defmodule CodeAdvent.DayEighteen.Runner do
  alias CodeAdvent.DayEighteen.Grid
  alias CodeAdvent.DayEighteen.Switcher

  def next(%Grid{} = grid) do
    grid
      |> Grid.coord_tuples
      |> Enum.reduce(grid, &update(&1, &2, grid))
  end

  defp update({x, y}, grid, starting_grid) do
    new_value = Switcher.next_value(starting_grid, x, y)
    grid
      |> Grid.set(x, y, new_value)
  end
end
