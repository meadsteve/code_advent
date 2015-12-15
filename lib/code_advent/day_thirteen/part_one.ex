defmodule CodeAdvent.DayThirteen.PartOne do
  @file_path "lib/code_advent/day_thirteen/input_data.txt"

  alias CodeAdvent.DayThirteen.Parser
  alias CodeAdvent.DayThirteen.Parser.Data

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
    @file_path
    |> File.read!
    |> run
  end

  def run(string) do
    data = Parser.parse_data(string)
    [highest] = data.people
      |> Permutations.of_list()
      |> Enum.map(fn order -> happiness(order, data) end)
      |> Enum.sort(&(&1 > &2))
      |> Enum.take(1)

    highest |> answer_as_string
  end

  def parse_data(string), do: Parser.parse_data(string)

  def happiness([first | rest], data) do
    happiness([first | rest], data, total: 0, first: first)
  end

  defp happiness([last], data, total: total, first: first) do
    total + happiness_change(last, first, data)
  end

  defp happiness([next, neighbour | rest], data, total: total, first: first) do
    new_total = total + happiness_change(next, neighbour, data)
    happiness([neighbour | rest], data, total: new_total, first: first)
  end

  defp happiness_change(a, b, data) do
    data.hapiness[a][b] + data.hapiness[b][a]
  end

  defp answer_as_string(thing), do: "#{inspect thing}"

  defp debug(thing) do
    IO.puts "#{inspect thing}"
    thing
  end

end
