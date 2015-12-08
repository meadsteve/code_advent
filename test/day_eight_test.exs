defmodule DayEightTest do
  use ExUnit.Case


  test "First example" do
    strings = """
    ""
    """ |> String.split
    assert CodeAdvent.DayEight.PartOne.run(strings) == 2
  end

  test "Second example" do
    strings = """
    "ABC"
    """ |> String.split
    assert CodeAdvent.DayEight.PartOne.run(strings) == 2
  end

  test "fourth example" do
    strings = """
    "\x27"
    """ |> String.split
    assert CodeAdvent.DayEight.PartOne.run(strings) == 2
  end


end
