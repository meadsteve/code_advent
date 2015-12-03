defmodule CodeAdvent.DayThree.PartTwo do
  @file_path "lib/code_advent/day_three/input_data.txt"

  defmodule SantaAdventure do
    defstruct x: 0,
              y: 0,
              stops: [{0, 0}]
  end

  def run() do
    move_data = @file_path
      |> File.read!
      |> String.graphemes

    santa_adventure = move_data
      |> Stream.take_every(2)
      |> Enum.reduce(%SantaAdventure{}, &move_santa/2)

    robo_adventure = move_data
      |> Stream.drop(1)
      |> Stream.take_every(2)
      |> Enum.reduce(%SantaAdventure{}, &move_santa/2)

    santa_adventure
      |> combined_deduped_stops(robo_adventure)
      |> answer_as_string
  end

  defp move_santa(">", %SantaAdventure{x: x, y: y, stops: stops}) do
    %SantaAdventure{x: x + 1, y: y, stops: [ {x + 1, y} | stops]}
  end

  defp move_santa("<", %SantaAdventure{x: x, y: y, stops: stops}) do
    %SantaAdventure{x: x - 1, y: y, stops: [ {x - 1, y} | stops]}
  end

  defp move_santa("v", %SantaAdventure{x: x, y: y, stops: stops}) do
    %SantaAdventure{x: x, y: y + 1, stops: [ {x, y + 1} | stops]}
  end

  defp move_santa("^", %SantaAdventure{x: x, y: y, stops: stops}) do
    %SantaAdventure{x: x, y: y - 1, stops: [ {x, y - 1} | stops]}
  end

  defp move_santa(_, adventure), do: adventure

  defp combined_deduped_stops(%{stops: stops_a}, %{stops: stops_b}) do
    stops_a
      |> Enum.into(stops_b)
      |> Enum.uniq()
  end


  defp answer_as_string(stops) do
    "#{Enum.count(stops)} stops"
  end
end
