defmodule CodeAdvent.DayTwentyOne.PartOne do
  alias CodeAdvent.DayTwentyOne.PartOne.Extra

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


  defmodule Person do
    defstruct hp: 100,
              armor: 0,
              damage: 0,
              money_spent: 0,
              name: "unknown"

    def new_boss, do: %__MODULE__{hp: 104, damage: 8, armor: 1, name: "boss"}
    def new_player, do: %__MODULE__{hp: 100, damage: 0, armor: 0, name: "player"}
  end

  defmodule Game do
    defstruct player: nil,
              boss: nil

    def new, do: %__MODULE__{player: Person.new_player, boss: Person.new_boss}
    def new(player), do: %__MODULE__{player: player, boss: Person.new_boss}
  end

  def run() do
    [cheapest_game] = player_options()
      |> Enum.map(&Game.new(&1))
      |> Enum.map(&play_out/1)
      |> Enum.filter(fn game -> winner(game) == :player end)
      |> Enum.sort(fn a, b -> a.player.money_spent < b.player.money_spent end)
      |> Enum.take(1)

    cheapest_game.player.money_spent |> as_string
  end

  def player_options do
    ring_options = [[]]
    ++ Extra.combination(1, @rings)
    ++ Extra.combination(2, @rings)

    for rings <- ring_options, weapon <- @weapons, armor <- @armor do
      Person.new_player |> buy([weapon, armor | rings])
    end
  end

  def play_out(%Game{} = start_game) do
    [end_state] = start_game
      |> Stream.unfold(fn game -> updated_game = turn(game);{updated_game, updated_game} end)
      |> Stream.drop_while(fn x -> is_over?(x) == false end)
      |> Enum.take(1)
    end_state
  end

  def turn(%Game{} = game) do
    updated_boss = game.boss |> is_attacked_by(game.player)
    updated_player = game.player |> is_attacked_by(updated_boss)
    %{game | player: updated_player, boss: updated_boss}
  end

  def is_over?(%Game{} = game) do
    if game.boss.hp > 0 && game.player.hp > 0 do
      false
    else
      true
    end
  end

  def winner(%Game{player: %{hp: player_hp}, boss: %{hp: _boss_hp}})
  when player_hp <= 0, do: :boss
  def winner(%Game{player: %{hp: _player_hp}, boss: %{hp: boss_hp}})
  when boss_hp <= 0, do: :player

  def is_attacked_by(%Person{} = defender, %Person{hp: attack_hp} = attacker)
  when attack_hp > 0
  do
    %{defender | hp: defender.hp - damage_dealt(defender, attacker)}
  end

  def is_attacked_by(%Person{} = defender, _), do: defender

  defp damage_dealt(%Person{} = defender, %Person{} = attacker) do
    max(attacker.damage - defender.armor, 1)
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

  defp as_string(n), do: "#{n}"
end
