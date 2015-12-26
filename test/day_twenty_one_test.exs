defmodule DayTwentyOneTest do
  use ExUnit.Case
  alias CodeAdvent.DayTwentyOne.PartOne

  test "Attackarmorut armor involved takes off the damage score" do
    defender = %PartOne.Person{hp: 100}
    attacker = %PartOne.Person{damage: 10}

    updated_defender = defender |> PartOne.is_attacked_by(attacker)
    assert updated_defender.hp == 90
  end

  test "Attack damage is reduced by armor" do
    defender = %PartOne.Person{hp: 100, armor: 5}
    attacker = %PartOne.Person{damage: 10}

    updated_defender = defender |> PartOne.is_attacked_by(attacker)
    assert updated_defender.hp == 95
  end

  test "Attacks always do at least one damange" do
    defender = %PartOne.Person{hp: 100, armor: 11}
    attacker = %PartOne.Person{damage: 10}

    updated_defender = defender |> PartOne.is_attacked_by(attacker)
    assert updated_defender.hp == 99
  end

  test "Dead people's attacks do no damage" do
    defender = %PartOne.Person{hp: 100, armor: 5}
    attacker = %PartOne.Person{damage: 10, hp: 0}

    updated_defender = defender |> PartOne.is_attacked_by(attacker)
    assert updated_defender.hp == 100
  end

  test "A game turn causes the player to attack then the boss to return" do
    updated_game = PartOne.Game.new
      |> PartOne.turn
    assert updated_game.player.hp == 92 # Boss has hit player
  end

  test "A game is over when either the player or boss is dead" do
    new_game = PartOne.Game.new
    dead_player_game = new_game
      |> Map.put(:player, %PartOne.Person{hp: 0})
    dead_boss_game = new_game
      |> Map.put(:boss, %PartOne.Person{hp: 0})

    assert PartOne.is_over?(dead_player_game) == true
    assert PartOne.is_over?(dead_boss_game) == true
    assert PartOne.is_over?(new_game) == false
  end

  test "The default game runs until the player is dead" do
    dead_player_game = PartOne.Game.new
      |> PartOne.play_out

    assert PartOne.is_over?(dead_player_game) == true
    assert dead_player_game.player.hp <= 0
  end

  test "The winner of the game can be determined" do
    new_game = PartOne.Game.new
    dead_player_game = new_game
      |> Map.put(:player, %PartOne.Person{hp: 0})
    dead_boss_game = new_game
      |> Map.put(:boss, %PartOne.Person{hp: 0})

    assert PartOne.winner(dead_player_game) == :boss
    assert PartOne.winner(dead_boss_game) == :player
  end

  test "Buying items increases money spent" do
    item_cost = 10
    item = {:ring, "Item", item_cost, 0, 0}
    updated_person = %PartOne.Person{} |> PartOne.buy item
    assert updated_person.money_spent == item_cost
  end

  test "Buying items increases stats as expected" do
    damage_change = 5
    armor_change = 3
    item = {:ring, "Item", 0, damage_change, armor_change}
    starting_person =  %PartOne.Person{armor: 10, damage: 11}
    updated_person = starting_person |> PartOne.buy item
    assert updated_person.armor == 13
    assert updated_person.damage == 16
  end

end
