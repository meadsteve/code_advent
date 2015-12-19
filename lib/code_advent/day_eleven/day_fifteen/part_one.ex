defmodule CodeAdvent.DayFifteen.PartOne do
  @file_path "lib/code_advent/day_fifteen/input_data.txt"
  @input_pattern ~r/(?<name>[a-z]+): capacity (?<capacity>\-?[0-9]+), durability (?<durability>\-?[0-9]+), flavor (?<flavor>\-?[0-9]+), texture (?<texture>\-?[0-9]+), calories (?<calories>\-?[0-9]+)/i

  defmodule Ingredient do
    defstruct name: "",
              capacity: nil,
              durability: nil,
              flavor: nil,
              texture: nil,
              calories: nil
  end

  def run() do
    [i1, i2, i3, i4] = @file_path
      |> File.read!
      |> String.split("\n", trim: true)
      |> Enum.map(&parse/1)

    combinations = for c1 <- 0..100,
        c2 <- 0..100,
        c3 <- 0..100,
        c4 <- 0..100,
        c1 + c2 + c3 + c4 == 100,
        list = [{c1, i1}, {c2, i2}, {c3, i3}, {c4, i4}],
        list_score = score(list)
    do
      {list_score, list}
    end

    [winner | _] = combinations
      |> Enum.sort(fn ({a, _},{b, _}) -> a > b end)

    winner |> as_string
  end

  def parse(line) do
    data = Regex.named_captures(@input_pattern, line)
    %Ingredient{
      name:       data["name"],
      capacity:   data["capacity"] |> to_int!,
      durability: data["durability"] |> to_int!,
      flavor:     data["flavor"] |> to_int!,
      texture:    data["texture"] |> to_int!,
      calories:   data["calories"] |> to_int!
    }
  end

  def score(items) do
    [:capacity, :durability, :flavor, :texture]
      |> Enum.map(&score_for(items, &1))
      |> multiply_together
  end

  defp multiply_together(list) do
     Enum.reduce(list, 1, fn (x, t) -> x * t end)
  end

  def score_for(items, thing) do
    score = items
      |> Enum.map(fn {quantity, ingredient} -> quantity * Map.get(ingredient, thing) end)
      |> Enum.sum
    max(score, 0)
  end

  defp to_int!(string) do
    {int, ""} = Integer.parse(string)
    int
  end

  defp as_string({n, _}), do: "#{n}"
end
