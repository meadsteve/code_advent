defmodule CodeAdvent.DaySixteen.PartTwo do
  alias CodeAdvent.DaySixteen.PartOne

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

  @less_than_facts ["pomeranians", "goldfish"]
  @greater_than_facts ["trees", "cats"]

  def run(), do: PartOne.run(&valid_aunt?/1)

  def valid_aunt?(aunt), do: PartOne.valid_aunt?(aunt, &invalid_fact?/1)

  def invalid_fact?({thing, number}) do
    if Map.has_key?(@known_facts, thing) do
      !in_valid_range(thing, number)
    else
      false
    end
  end

  for x <- @less_than_facts do
    def in_valid_range(unquote(x), number), do: @known_facts[unquote(x)] > number
  end
  for y <- @greater_than_facts do
    def in_valid_range(unquote(y), number), do: @known_facts[unquote(y)] < number
  end

  def in_valid_range(thing, number), do: @known_facts[thing] == number

end
