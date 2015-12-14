defmodule CodeAdvent.DayThirteen.PartOne do
  @file_path "lib/code_advent/day_thirteen/input_data.txt"

  @input_pattern ~r/(?<person>[a-z]+) would (?<sign>[a-z]+) (?<amount>[0-9]+) happiness units by sitting next to (?<neighbour>[a-z]+)\./i

  defmodule Data do
    defstruct people: [], hapiness: %{}
  end

  defmodule Permutations do
    def of_list([]) do
      [[]]
    end

    # Ugly and probs slow but YOLO
    def of_list(list) do
      for h <- list, t <- of_list(list -- [h]), do: [h | t]
    end
  end


  def run() do

  end

  def parse_data(string) do
    line_data = string
      |> String.split("\n", trim: true)
      |> Enum.map(&Regex.named_captures(@input_pattern, &1))

    people = line_data
      |> Enum.map(fn %{"person" => person} -> person end)
      |> Enum.uniq

    hapiness = line_data
      |> Enum.reduce(%{}, &add_hapiness_entry/2)
    %Data{people: people, hapiness: hapiness}
  end

  defp add_hapiness_entry(entry, happy_map) do
    happy_map
      |> check_entry_exists(entry["person"])
      |> Map.update!(entry["person"], &update_person_happy_map(&1, entry))
  end

  defp update_person_happy_map(map, entry) do
    Map.put(map, entry["neighbour"], hapiness_change(entry))
  end

  defp hapiness_change(%{"sign" => "gain", "amount" => x}), do: to_int!(x)
  defp hapiness_change(%{"sign" => "lose", "amount" => x}), do: -to_int!(x)

  defp to_int!(string) do
    {int, ""} = Integer.parse(string)
    int
  end

  defp check_entry_exists(happy_map, person) do
    if !Map.has_key?(happy_map, person) do
      happy_map |> Map.put_new(person, %{})
    else
      happy_map
    end
  end

  defp answer_as_string(thing), do: "#{inspect thing}"

  defp debug(thing) do
    IO.puts "#{inspect thing}"
    thing
  end

end
