defmodule DayFifteenTest do
  use ExUnit.Case
  alias CodeAdvent.DayFifteen.PartOne
  alias CodeAdvent.DayFifteen.PartTwo

  test "It can parse ingredients lines" do
    line = """
    Sprinkles: capacity 2, durability 0, flavor -2, texture 0, calories 3
    """
    assert PartOne.parse(line) == %PartOne.Ingredient{
      name: "Sprinkles",
      capacity: 2,
      durability: 0,
      flavor: -2,
      texture: 0,
      calories: 3
    }
  end

  test "It scores combinations as in the example" do
    butterscotch = %PartOne.Ingredient{
      name: "Butterscotch",
      capacity: -1,
      durability: -2,
      flavor: 6,
      texture: 3,
      calories: 8
    }
    cinnamon =  %PartOne.Ingredient{
      name: "Cinnamon",
      capacity: 2,
      durability: 3,
      flavor: -2,
      texture: -1,
      calories: 3
    }
    items = [
      {44, butterscotch},
      {56, cinnamon}
    ]
    assert PartOne.score(items) == 62842880
  end

  test "It can calculate calories in a cookie" do
    butterscotch = %PartOne.Ingredient{
      name: "Butterscotch",
      capacity: -1,
      durability: -2,
      flavor: 6,
      texture: 3,
      calories: 8
    }
    cinnamon =  %PartOne.Ingredient{
      name: "Cinnamon",
      capacity: 2,
      durability: 3,
      flavor: -2,
      texture: -1,
      calories: 3
    }
    items = [
      {40, butterscotch},
      {60, cinnamon}
    ]
    assert PartTwo.calories(items) == 500
  end

end
