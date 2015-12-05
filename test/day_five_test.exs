defmodule DayFiveTest do
  use ExUnit.Case

  @part_one_sample """
  ugknbfddgicrmopn
  """

  @part_one_bad_sample """
  steve
  eeezzcd
  """

  test "PartOne: counts nice strings" do
    assert CodeAdvent.DayFive.PartOne.run(@part_one_sample) == "1"
  end

  test "PartOne: doesn't count bad strings" do
    assert CodeAdvent.DayFive.PartOne.run(@part_one_bad_sample) == "0"
  end

  @part_two_sample """
  qjhvhtzxzqqjkmpb
  """

  @part_two_bad_sample """
  sxs
  """

  test "PartTwo: counts nice strings" do
    assert CodeAdvent.DayFive.PartTwo.run(@part_two_sample) == "1"
  end

  test "PartTwo: doesn't count bad strings" do
    assert CodeAdvent.DayFive.PartTwo.run(@part_two_bad_sample) == "0"
  end

end
