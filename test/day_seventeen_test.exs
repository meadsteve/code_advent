defmodule DaySeventeenTest do
  use ExUnit.Case
  alias CodeAdvent.DaySeventeen.PartOne

  test "Single option works" do
    containers = [3]
    assert PartOne.container_options(containers, 3) == [[3]]
  end

  test "Combination works" do
    containers = [1, 2]
    assert PartOne.container_options(containers, 3) == [[2, 1]]
  end

  test "multi combination works" do
    containers = [1, 1, 2]
    assert PartOne.container_options(containers, 3) == [[2, 1], [2, 1]]
  end



end
