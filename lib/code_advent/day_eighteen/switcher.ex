defmodule CodeAdvent.DayEighteen.Switcher do
  alias CodeAdvent.DayEighteen.Grid

  def next_value(%Grid{} = grid, x, y) do
    active_neighbours = grid
      |> Grid.get_neighbours(x, y)
      |> count_switched_on_lights
    current_value = Grid.get(grid, x, y)
    next_value(current_value, active_neighbours: active_neighbours)
  end

  defp next_value(:on, active_neighbours: 2), do: :on
  defp next_value(:on, active_neighbours: 3), do: :on
  defp next_value(:on, _),                    do: :off

  defp next_value(:off, active_neighbours: 3), do: :on
  defp next_value(:off, _),                    do: :off

  defp count_switched_on_lights(neighbours) do
    neighbours
      |> Enum.filter(&(&1 == :on))
      |> Enum.count
  end

end
