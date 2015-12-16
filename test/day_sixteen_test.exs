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


end
