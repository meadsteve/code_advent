defmodule CodeAdvent.DayTwentyOne.PartOne.GameEngine do

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
end
