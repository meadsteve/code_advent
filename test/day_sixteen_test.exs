defmodule DaySixteenTest do
  use ExUnit.Case
  alias CodeAdvent.DaySixteen.PartOne

  test "Parses the facts I remember about an aunt" do
    line = """
    Sue 1: cars: 9, akitas: 3, goldfish: 0
    """
    assert PartOne.parse(line) == %PartOne.Aunt{
      name: "Sue 1",
      facts: [
        {"cars", 9},
        {"akitas", 3},
        {"goldfish", 0}
      ]
    }
  end

  test "Can invalidate a fact" do
    fact = {"goldfish", 6}
    assert PartOne.invalid_fact?(fact) == true
  end

  test "won't invalidate unknown facts" do
    fact = {"steves", 1}
    assert PartOne.invalid_fact?(fact) == false
  end

  test "Can invalidate an aunt" do
    aunt = %PartOne.Aunt{
      name: "Sue 1",
      facts: [
        {"goldfish", 5},
        {"cars", 9}
      ]
    }
    # Wrong number of cars
    assert PartOne.invalid_aunt?(aunt) == true
  end


end
