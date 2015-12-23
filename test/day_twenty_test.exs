defmodule DayTwentyTest do
  use ExUnit.Case
  alias CodeAdvent.DayTwenty.PartOne

  test "Present count function returns all the correct numbers" do
    assert PartOne.present_count(house_number: 1) == 10
    assert PartOne.present_count(house_number: 2) == 30
    assert PartOne.present_count(house_number: 3) == 40
    assert PartOne.present_count(house_number: 4) == 70
    assert PartOne.present_count(house_number: 5) == 60
  end

  test "House stream is infinite and returns the present counts" do
    assert (PartOne.house_stream |> Enum.take(1)) == [10]
    assert (PartOne.house_stream |> Enum.take(4)) == [10, 30, 40, 70]
  end

  test "Finds first house with requested present count" do
    assert PartOne.find_min_house_with_presents(10) == 1
    assert PartOne.find_min_house_with_presents(70) == 4
    assert PartOne.find_min_house_with_presents(130) == 8
  end

end
