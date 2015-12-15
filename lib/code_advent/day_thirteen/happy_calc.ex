defmodule CodeAdvent.DayThirteen.HappyCalc do
  def happiness([first | rest], data) do
    happiness([first | rest], data, total: 0, first: first)
  end

  defp happiness([last], data, total: total, first: first) do
    total + happiness_change(last, first, data)
  end

  defp happiness([next, neighbour | rest], data, total: total, first: first) do
    new_total = total + happiness_change(next, neighbour, data)
    happiness([neighbour | rest], data, total: new_total, first: first)
  end

  defp happiness_change(a, b, data) do
    data.hapiness[a][b] + data.hapiness[b][a]
  end
end
