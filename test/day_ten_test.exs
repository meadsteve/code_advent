defmodule DayTenTest do
  use ExUnit.Case


  test "1 gives 11" do
    assert CodeAdvent.DayTen.PartOne.convert("1") == "11"
  end

  test "11 gives 21" do
    assert CodeAdvent.DayTen.PartOne.convert("11") == "21"
  end

  test "111221 gives 312211" do
    assert CodeAdvent.DayTen.PartOne.convert("111221") == "312211"
  end

  test "run, times: works as expected" do
    piped_result = "3113322113"
      |> CodeAdvent.DayTen.PartOne.convert()
      |> CodeAdvent.DayTen.PartOne.convert()
      |> CodeAdvent.DayTen.PartOne.convert()
      |> CodeAdvent.DayTen.PartOne.convert()

    times_result = CodeAdvent.DayTen.PartOne.run("3113322113", times: 4)

    assert piped_result == times_result
  end

  test "running 5 times gives expected result" do
    assert CodeAdvent.DayTen.PartOne.run("1", times: 5) == "312211"
  end


end
