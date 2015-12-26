defmodule CodeAdvent.DayTwentyOne.PartTwo do
  alias CodeAdvent.DayTwentyOne.PartOne
  alias CodeAdvent.DayTwentyOne.PartOne.GameEngine

  def run() do
    [expensive_lost_game] = PartOne.player_options()
      |> Enum.map(&GameEngine.Game.new(&1))
      |> Enum.map(&GameEngine.play_out/1)
      |> Enum.filter(fn game -> GameEngine.winner(game) == :boss end)
      |> Enum.sort(fn a, b -> a.player.money_spent > b.player.money_spent end)
      |> Enum.take(1)

    expensive_lost_game.player.money_spent |> as_string
  end

  defp as_string(n), do: "#{n}"
end
