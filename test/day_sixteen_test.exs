defmodule DaySixteenTest do
  use ExUnit.Case
  alias CodeAdvent.DaySixteen.PartOne
  alias CodeAdvent.DaySixteen.PartTwo

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
    assert PartOne.valid_aunt?(aunt) == false
  end

  test "Part Two: won't invalidate unknown facts" do
    fact = {"steves", 1}
    assert PartTwo.invalid_fact?(fact) == false
  end

  test "Part Two: cats and trees are greater than facts" do
    fact = {"cats", 8}
    assert PartTwo.invalid_fact?(fact) == false
    fact2 = {"trees", 5}
    assert PartTwo.invalid_fact?(fact2) == false
  end

  test "Part Two: pomeranians and goldfish are less than facts" do
    fact = {"pomeranians", 2}
    assert PartTwo.invalid_fact?(fact) == false
    fact2 = {"goldfish", 1}
    assert PartTwo.invalid_fact?(fact2) == false
  end


end
