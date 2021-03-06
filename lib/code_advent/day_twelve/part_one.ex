defmodule CodeAdvent.DayTwelve.PartOne do
  alias Poison.Parser

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
      |> parse_line
      |> get_sum
  end

  def parse_line(line) do
    Parser.parse!(line)
  end

  def get_sum(map) when is_map(map), do: map |> Map.values |> get_sum
  def get_sum(items) when is_list(items) do
    items
      |> Enum.map(&get_sum/1)
      |> Enum.sum
  end
  def get_sum(x) when is_number(x) , do: x
  def get_sum(x) when is_binary(x) , do: 0

  def as_string(x), do: "#{x}"

end
