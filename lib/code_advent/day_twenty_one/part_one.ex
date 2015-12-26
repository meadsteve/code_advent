defmodule CodeAdvent.DayTwentyOne.PartOne do
  alias CodeAdvent.DayTwentyOne.PartOne.Shop
  alias CodeAdvent.DayTwentyOne.PartOne.GameEngine

  def run() do
    [cheapest_game] = player_options()
      |> Enum.map(&GameEngine.Game.new(&1))
      |> Enum.map(&GameEngine.play_out/1)
      |> Enum.filter(fn game -> GameEngine.winner(game) == :player end)
      |> Enum.sort(fn a, b -> a.player.money_spent < b.player.money_spent end)
      |> Enum.take(1)

    cheapest_game.player.money_spent |> as_string
  end

  def player_options do
    GameEngine.Person.new_player
      |> Shop.equipped_player_options
  end

  defp as_string(n), do: "#{n}"
end
