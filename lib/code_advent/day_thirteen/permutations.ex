defmodule CodeAdvent.DayThirteen.Permutations do
  def of_list([]) do
    [[]]
  end

  # Ugly and probs slow but YOLO
  def of_list(list) do
    for h <- list, t <- of_list(list -- [h]), do: [h | t]
  end
end
