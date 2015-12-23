defmodule CodeAdvent.DayTwentyOne.PartOne do

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
    {:armor, "Platemail", 102, 0, 5}
  ]

  @rings [
    {:ring, "Damage +1", 25, 1, 0},
    {:ring, "Damage +2", 50, 2, 0},
    {:ring, "Damage +3", 100, 3, 0},
    {:ring, "Defense +1", 20, 0, 1},
    {:ring, "Defense +2", 40, 0, 2},
    {:ring, "Defense +3", 80, 0, 3}
  ]


  defmodule Person do
    defstruct hp: 100,
              armor: 0,
              damage: 0,
              money_spent: 0

    def new_boss, do: %__MODULE__{hp: 104, damage: 8, armor: 1}
    def new_player, do: %__MODULE__{hp: 100, damage: 0, armor: 0}
  end

  def run() do

  end

  def is_attacked_by(%Person{} = defender, %Person{} = attacker) do
    %{defender | hp: defender.hp - damage_dealt(defender, attacker)}
  end

  defp damage_dealt(%Person{} = defender, %Person{} = attacker) do
    max(attacker.damage - defender.armor, 1)
  end

  def buy(%Person{} = buyer, {_item_type, name, cost, d_change, a_change}) do
    %{buyer |
      money_spent: buyer.money_spent + cost,
      armor: buyer.armor + a_change,
      damage: buyer.damage + d_change
    }
  end

  defp as_string(n), do: "#{n}"
end
