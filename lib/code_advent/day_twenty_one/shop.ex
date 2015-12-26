defmodule CodeAdvent.DayTwentyOne.PartOne.Shop do
  alias CodeAdvent.DayTwentyOne.PartOne.Extra
  alias CodeAdvent.DayTwentyOne.PartOne.GameEngine.Person

  # Name  Cost  Damage  Armor
  @weapons [
    {:weapon, "Dagger", 8, 4, 0},
    {:weapon, "Shortsword", 10, 5, 0},
    {:weapon, "Warhammer", 25, 6, 0},
    {:weapon, "Longsword", 40, 7, 0},
    {:weapon, "Greataxe", 74, 8, 0}
  ]

  @armor [
    {:armor, "Leather", 13, 0, 1},
    {:armor, "Chainmail", 31, 0, 2},
    {:armor, "Splintmail", 53, 0, 3},
    {:armor, "Bandedmail", 75, 0, 4},
    {:armor, "Platemail", 102, 0, 5},
    {:armor, "Cotton vest", 0, 0, 0}
  ]

  @rings [
    {:ring, "Damage +1", 25, 1, 0},
    {:ring, "Damage +2", 50, 2, 0},
    {:ring, "Damage +3", 100, 3, 0},
    {:ring, "Defense +1", 20, 0, 1},
    {:ring, "Defense +2", 40, 0, 2},
    {:ring, "Defense +3", 80, 0, 3}
  ]


  def equipped_player_options(player) do
    ring_options = [[]]
    ++ Extra.combination(1, @rings)
    ++ Extra.combination(2, @rings)

    for rings <- ring_options, weapon <- @weapons, armor <- @armor do
      player |> buy([weapon, armor | rings])
    end
  end

  def buy(%Person{} = buyer, items) when is_list(items) do
    items |> Enum.reduce(buyer, &buy(&2, &1))
  end

  def buy(%Person{} = buyer, {_item_type, name, cost, d_change, a_change}) do
    %{buyer |
      money_spent: buyer.money_spent + cost,
      armor: buyer.armor + a_change,
      damage: buyer.damage + d_change
    }
  end

end
