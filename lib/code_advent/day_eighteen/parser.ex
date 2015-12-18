defmodule CodeAdvent.DayEighteen.Parser do
  alias CodeAdvent.DayEighteen.Grid

  def parse(string) do
    rows = string |> String.split("\n", trim: true)
    size = rows |> grid_size

    {grid, _, _} = Enum.reduce(rows, {Grid.new(size), 0, 0}, &parse_row/2)
    grid
  end

  defp parse_row(row, {grid, x, y}) do
    {updated_grid, _, _} = row
      |> String.graphemes
      |> Enum.reduce({grid, x, y}, &parse_cell/2)
    {updated_grid, x, y + 1}
  end

  defp parse_cell(cell, {grid, x, y}) do
    updated_grid = Grid.set(grid, x, y, cell_meaning(cell))
    {updated_grid, x + 1, y}
  end

  defp cell_meaning("."), do: :off
  defp cell_meaning("#"), do: :on

  defp grid_size([first | _]) do
    #Lazy. Assume all rows are the same length
    String.length(first)
  end
end
