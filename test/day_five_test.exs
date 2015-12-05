defmodule DayFiveTest do
  use ExUnit.Case

  @sample """
  ugknbfddgicrmopn
  """

  @bad_sample """
  steve
  eeezzcd
  """

  test "counts nice strings" do
    assert CodeAdvent.DayFive.PartOne.run(@sample) == "1"
  end

  test "doesn't count bad strings" do
    assert CodeAdvent.DayFive.PartOne.run(@bad_sample) == "0"
  end

end
