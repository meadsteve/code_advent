defmodule DayThirteenTest do
  use ExUnit.Case
  alias CodeAdvent.DayThirteen.PartOne


  test "parses all the correct people from the input" do
    input = """
    Alice would lose 2 happiness units by sitting next to Bob.
    Bob would gain 93 happiness units by sitting next to Alice.
    Carol would lose 54 happiness units by sitting next to Alice.
    """
    data = PartOne.parse_data(input)
    assert data.people == ["Alice", "Bob", "Carol"]
  end

  test "parses the hapiness of sitting next to each neighbour" do
    input = """
    Alice would lose 2 happiness units by sitting next to Bob.
    Alice would gain 6 happiness units by sitting next to Carol.
    Bob would gain 93 happiness units by sitting next to Alice.
    Carol would lose 54 happiness units by sitting next to Alice.
    """
    data = PartOne.parse_data(input)
    assert data.hapiness["Alice"] == %{"Bob" => -2, "Carol" => 6}
    assert data.hapiness["Bob"] == %{"Alice" => 93}
  end


end
