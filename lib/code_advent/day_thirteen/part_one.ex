defmodule CodeAdvent.DayThirteen.PartOne do
  @file_path "lib/code_advent/day_thirteen/input_data.txt"

  alias CodeAdvent.DayThirteen.Parser
  alias CodeAdvent.DayThirteen.Parser.Data
  alias CodeAdvent.DayThirteen.HappyCalc
  alias CodeAdvent.DayThirteen.Permutations

  def run() do
    @file_path
    |> File.read!
    |> run
  end

  def run(string) do
    data = Parser.parse_data(string)
    [highest] = data.people
      |> Permutations.of_list()
      |> Enum.map(fn order -> HappyCalc.happiness(order, data) end)
      |> Enum.sort(&(&1 > &2))
      |> Enum.take(1)

    highest |> answer_as_string
  end


  defp answer_as_string(thing), do: "#{inspect thing}"

  defp debug(thing) do
    IO.puts "#{inspect thing}"
    thing
  end

end
