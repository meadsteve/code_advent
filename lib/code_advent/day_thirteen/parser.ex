defmodule CodeAdvent.DayThirteen.Parser do
  @input_pattern ~r/(?<person>[a-z]+) would (?<sign>[a-z]+) (?<amount>[0-9]+) happiness units by sitting next to (?<neighbour>[a-z]+)\./i

  defmodule Data do
    defstruct people: [], hapiness: %{}
  end

  def parse_data(string) do
    line_data = string
      |> String.split("\n", trim: true)
      |> Enum.map(&Regex.named_captures(@input_pattern, &1))

    people = line_data
      |> Enum.map(fn %{"person" => person} -> person end)
      |> Enum.uniq

    hapiness = line_data
      |> Enum.reduce(%{}, &hapiness_entry_reducer/2)
    %Data{people: people, hapiness: hapiness}
  end

  def add_hapiness_entry(happy_map, entry) do
    happy_map
      |> ensure_entry_exists(entry["person"])
      |> Map.update!(entry["person"], &update_person_happy_map(&1, entry))
  end

  defp hapiness_entry_reducer(entry, happy_map) do
    add_hapiness_entry(happy_map, entry)
  end

  def add_hapiness_entry(entry, happy_map) do
    happy_map
      |> ensure_entry_exists(entry["person"])
      |> Map.update!(entry["person"], &update_person_happy_map(&1, entry))
  end

  defp update_person_happy_map(map, entry) do
    Map.put(map, entry["neighbour"], hapiness_change(entry))
  end

  defp hapiness_change(%{"amount" => "0"}), do: 0
  defp hapiness_change(%{"sign" => "gain", "amount" => x}), do: to_int!(x)
  defp hapiness_change(%{"sign" => "lose", "amount" => x}), do: -to_int!(x)

  defp to_int!(string) do
    {int, ""} = Integer.parse(string)
    int
  end

  defp ensure_entry_exists(map, key) do
    if !Map.has_key?(map, key) do
      map |> Map.put_new(key, %{})
    else
      map
    end
  end


end
