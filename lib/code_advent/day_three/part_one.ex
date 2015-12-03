defmodule CodeAdvent.DayThree.PartOne do
  @file_path "lib/code_advent/day_three/input_data.txt"

  defmodule SantaAdventure do
    defstruct x: 0,
              y: 0,
              stops: [{0, 0}]
  end

  def run() do
    adventure = %SantaAdventure{}
    @file_path
      |> File.read!
      |> String.graphemes
      |> Enum.reduce(adventure, &move_santa/2)
      |> dedupe_stops
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

  defp dedupe_stops(%SantaAdventure{stops: stops} = adventure) do
    %{adventure | stops: Enum.uniq(stops)}
  end

  defp answer_as_string(%SantaAdventure{stops: stops}) do
    "#{Enum.count(stops)} stops"
  end
end
