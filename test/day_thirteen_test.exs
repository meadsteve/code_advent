defmodule DayThirteenTest do
  use ExUnit.Case
  alias CodeAdvent.DayThirteen.PartOne
  alias CodeAdvent.DayThirteen.Parser
  alias CodeAdvent.DayThirteen.HappyCalc
  alias CodeAdvent.DayThirteen.Parser.Data


  test "parses all the correct people from the input" do
    input = """
    Alice would lose 2 happiness units by sitting next to Bob.
    Bob would gain 93 happiness units by sitting next to Alice.
    Carol would lose 54 happiness units by sitting next to Alice.
    """
    data = Parser.parse_data(input)
    assert data.people == ["Alice", "Bob", "Carol"]
  end

  test "parses the hapiness of sitting next to each neighbour" do
    input = """
    Alice would lose 2 happiness units by sitting next to Bob.
    Alice would gain 6 happiness units by sitting next to Carol.
    Bob would gain 93 happiness units by sitting next to Alice.
    Carol would lose 54 happiness units by sitting next to Alice.
    """
    data = Parser.parse_data(input)
    assert data.hapiness["Alice"] == %{"Bob" => -2, "Carol" => 6}
    assert data.hapiness["Bob"] == %{"Alice" => 93}
  end

  test "calculates the total hapiness of an arrangment" do
     data = %Data{
       people: ["Bob", "Alice", "Carol"],
       hapiness: %{
         "Bob" => %{"Alice" => 5, "Carol" => -2},
         "Alice" => %{"Bob" => 3, "Carol" => -5},
         "Carol" => %{"Alice" => 2, "Bob" => -1}
       }
     }
     assert HappyCalc.happiness(["Alice", "Bob", "Carol"], data) == 2
  end

  test "Works for example given" do
    example = """
      Alice would gain 54 happiness units by sitting next to Bob.
      Alice would lose 79 happiness units by sitting next to Carol.
      Alice would lose 2 happiness units by sitting next to David.
      Bob would gain 83 happiness units by sitting next to Alice.
      Bob would lose 7 happiness units by sitting next to Carol.
      Bob would lose 63 happiness units by sitting next to David.
      Carol would lose 62 happiness units by sitting next to Alice.
      Carol would gain 60 happiness units by sitting next to Bob.
      Carol would gain 55 happiness units by sitting next to David.
      David would gain 46 happiness units by sitting next to Alice.
      David would lose 7 happiness units by sitting next to Bob.
      David would gain 41 happiness units by sitting next to Carol.
    """
     assert PartOne.run(example) == "330"
  end


end
