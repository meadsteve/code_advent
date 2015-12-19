defmodule CodeAdvent.DayNineteen.PartOne do

  @file_path "lib/code_advent/day_nineteen/input_data.txt"

  defmodule Data do
    defstruct goal_string: nil,
              replacements: %{}
  end

  def run() do
    @file_path
      |> File.read!
      |> parse
      |> calibrate
      |> Enum.count
      |> as_string
  end

  def calibrate(data) do
    generate_molecules(data, data.goal_string)
  end

  def generate_molecules(data, starting_point) do
    data.replacements
      |> Enum.flat_map(&new_for_replacements(&1, starting_point))
      |> Enum.uniq
  end

  defp new_for_replacements({find, replacements}, string) do
    replacements
      |> Enum.flat_map(&new_for_replacement({find, &1}, string))
  end

  defp new_for_replacement({find, replace}, string) do
    parts = string
      |> String.split(find)
    swap_options = (Enum.count(parts) - 1)
    case swap_options do
      0 -> []
      max -> 1..max |> Enum.map(&join_swap(parts, find, replace, &1))
    end
  end

  defp join_swap(parts, regular_join, special_join, special_position) do
    first = parts |> Enum.take(special_position) |> Enum.join(regular_join)
    last = parts |> Enum.drop(special_position) |> Enum.join(regular_join)
    first <> special_join <> last
  end


  def parse(string) do
    [starting_string | replacements] = string
      |> String.split("\n", trim: true)
      |> Enum.reverse

    %Data{goal_string: starting_string,
          replacements: replacements_as_map(replacements)}
  end

  defp replacements_as_map(strings) do
    strings
      |> Enum.map(&String.split(&1, " => ", trim: true))
      |> Enum.reduce(%{}, &add_replacement_pair_to_map/2)
  end

  defp add_replacement_pair_to_map([find, replace], map) do
    Map.update(map, find, [replace], fn(prev) -> [replace | prev] end)
  end

  defp as_string(n), do: "#{n}"
end
