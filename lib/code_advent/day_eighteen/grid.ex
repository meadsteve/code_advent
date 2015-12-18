defmodule CodeAdvent.DayEighteen.Grid do
  defstruct size: nil,
            cells: %{},
            stuck_on_cells: %{}

  def new(size \\ 100) when is_number(size) do
    %__MODULE__{size: size}
  end

  def size(grid) do
    grid.size
  end

  def coord_tuples(grid) do
    max = size(grid) - 1
    for x <- 0..max, y <- 0..max, do: {x, y}
  end

  def light_count(%__MODULE__{cells: cells}) do
    cells
      |> Enum.filter(fn {_, x} -> x == :on end)
      |> Enum.count
  end

  def get(%__MODULE__{cells: cells, size: size}, x, y)
  when x < size and y < size and x >= 0 and y >= 0
  do
    key = x + (y * size)
    if Map.has_key?(cells, key) do
      cells[x + (y * size)]
    else
      :off
    end
  end

  def get(%__MODULE__{}, _, _), do: :off


  def get_neighbours(%__MODULE__{} = grid, x, y) do
    for xd <- -1..1, yd <- -1..1, (yd != 0) or (xd != 0) do
      get(grid, x+xd, y+yd)
    end
  end

  def stick_on(%__MODULE__{stuck_on_cells: stuck_on_cells} = grid, x, y) do
    updated_grid = grid
      |> set(x, y, :on)
    updated_stuck_on_cells = stuck_on_cells
      |> Map.put(x + (y * grid.size), true)
    %{updated_grid | stuck_on_cells: updated_stuck_on_cells}
  end

  def set(%__MODULE__{size: size} = grid, x, y, value)
  when x < size and y < size and x >= 0 and y >= 0
  do
    if (!stuck_on?(grid, x, y)) do
      updated_cells = grid.cells
        |> Map.put(x + (y * grid.size), value)
      %{grid | cells: updated_cells}
    else
      grid
    end
  end

  defp stuck_on?(%__MODULE__{} = grid, x, y) do
    Map.has_key?(grid.stuck_on_cells, x + (y * grid.size))
  end
end
