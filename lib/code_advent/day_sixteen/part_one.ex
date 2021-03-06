defmodule CodeAdvent.DaySixteen.PartOne do
  @file_path "lib/code_advent/day_sixteen/input_data.txt"
  @input_pattern ~r/(?<name>[a-z 0-9]+): (?<facts>.+)/i

  @known_facts %{
    "children" => 3,
    "cats" => 7,
    "samoyeds" => 2,
    "pomeranians" => 3,
    "akitas" => 0,
    "vizslas" => 0,
    "goldfish" => 5,
    "trees" => 3,
    "cars" => 2,
    "perfumes" => 1
  }

  defmodule Aunt do
    defstruct name: "Bob",
              facts: []
  end

  def run(aunt_validator \\ &valid_aunt?/1) do
    [aunt] = @file_path
      |> File.read!
      |> String.split("\n", trim: true)
      |> Enum.map(&parse/1)
      |> Enum.filter(aunt_validator)

    aunt |> as_string
  end

  def parse(line) do
    data = Regex.named_captures(@input_pattern, line)
    facts = data["facts"]
      |> String.split(", ", trim: true)
      |> Enum.map(&String.split(&1, ": "))
      |> Enum.map(fn [thing, count] -> {thing, count |> to_int!} end)
    %Aunt{
      name: data["name"],
      facts: facts
    }
  end

  def invalid_fact?({thing, number}) do
    if Map.has_key?(@known_facts, thing) do
      @known_facts[thing] != number
    else
      false
    end
  end

  def valid_aunt?(aunt, fact_validator \\ &invalid_fact?/1) do
    mistakes = aunt.facts
      |> Enum.filter(fact_validator)
      |> Enum.count
    mistakes == 0
  end

  defp to_int!(string) do
    {int, ""} = Integer.parse(string)
    int
  end

  defp as_string(%Aunt{} = aunt), do: "#{aunt.name}"
  defp as_string(n), do: "#{n}"
end
