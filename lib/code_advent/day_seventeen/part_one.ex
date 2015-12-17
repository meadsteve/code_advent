defmodule CodeAdvent.DaySeventeen.PartOne do
  @file_path "lib/code_advent/day_seventeen/input_data.txt"

  @goal_nog 150

  def run() do
    get_container_options_from_file
      |> Enum.count
      |> answer_as_string
  end

  def get_container_options_from_file do
    @file_path
      |> File.read!
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_int!/1)
      |> container_options(@goal_nog)
  end

  def container_options(containers, target) do
    container_options(containers, target, [])
  end

  defp container_options(_, 0, used) do
    [used]
  end

  defp container_options([], _, _) do
    []
  end

  defp container_options([next | rest], target, used) when next > target do
    container_options(rest, target, used)
  end

  defp container_options([next | rest], target, used) do
    container_options(rest, target - next, [next | used])
    ++ container_options(rest, target, used)
  end

  defp parse_int!(string) do
    {n, ""} = Integer.parse(string)
    n
  end

  defp answer_as_string(number), do: "#{number}"
end
