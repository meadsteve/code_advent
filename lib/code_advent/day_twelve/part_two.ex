defmodule CodeAdvent.DayTwelve.PartTwo do
  alias Poison.Parser
  alias CodeAdvent.DayTwelve.PartOne

  @file_path "lib/code_advent/day_twelve/input_data.txt"

  def run() do
    @file_path
      |> File.read!
      |> String.split("\n", trim: true)
      |> Enum.map(&sum_line/1)
      |> Enum.sum
      |> as_string
  end

  def sum_line(line) do
    line
      |> PartOne.parse_line
      |> get_sum
  end

  def is_red?(map) when is_map(map) do
    map |> Map.values |> Enum.member?("red")
  end
  def is_red?(_), do: false

  def get_sum(map) when is_map(map) do
    if (is_red?(map)) do
      0
    else
      map |> Map.values |> get_sum
    end
  end
  def get_sum(items) when is_list(items) do
    items
      |> Enum.map(&get_sum/1)
      |> Enum.sum
  end
  def get_sum(x) when is_number(x) , do: x
  def get_sum(x) when is_binary(x) , do: 0

  def as_string(x), do: "#{x}"

end
