defmodule CodeAdvent.DaySixteen.PartTwo do
  alias CodeAdvent.DaySixteen.PartOne

  @file_path "lib/code_advent/day_sixteen/input_data.txt"
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

  def run() do
    [aunt] = @file_path
      |> File.read!
      |> String.split("\n", trim: true)
      |> Enum.map(&parse/1)
      |> Enum.filter(&valid_aunt?/1)

    aunt |> as_string
  end

  def parse(line), do: PartOne.parse(line)

  def invalid_fact?({thing, number}) do
    if Map.has_key?(@known_facts, thing) do
      !in_valid_range(thing, number)
    else
      false
    end
  end

  def in_valid_range("pomeranians", number), do: @known_facts["pomeranians"] > number
  def in_valid_range("goldfish", number), do: @known_facts["goldfish"] > number
  def in_valid_range("trees", number), do: @known_facts["trees"] < number
  def in_valid_range("cats", number), do: @known_facts["cats"] < number
  def in_valid_range(thing, number), do: @known_facts[thing] == number

  def valid_aunt?(aunt), do: PartOne.valid_aunt?(aunt, &invalid_fact?/1)

  defp to_int!(string) do
    {int, ""} = Integer.parse(string)
    int
  end

  defp as_string(%PartOne.Aunt{} = aunt), do: "#{aunt.name}"
  defp as_string(n), do: "#{n}"
end
