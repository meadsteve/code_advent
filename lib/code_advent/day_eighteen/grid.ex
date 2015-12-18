defmodule CodeAdvent.DayEighteen.Grid do
  defstruct size: nil,
            cells: %{}

  def new(size \\ 100) when is_number(size) do
    %__MODULE__{size: size}
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

  def set(%__MODULE__{} = grid, x, y, value) do
    updated_cells = grid.cells
      |> Map.put(x + (y * grid.size), value)
    %{grid | cells: updated_cells}
  end
end
