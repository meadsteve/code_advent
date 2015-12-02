defmodule CodeAdvent.DayTwo.PartTwo do
  @file_path "lib/code_advent/day_two/input_data.txt"

  def run() do
    @file_path
      |> File.read!
      |> String.split
      |> Enum.map(&get_dimensions/1)
      |> Enum.map(&get_ribbon_length_for_dimensions/1)
      |> Enum.sum
      |> answer_as_string
  end

  defp get_dimensions(string) do
    string
      |> String.split("x")
      |> Enum.map(&to_int!/1)
  end

  defp get_ribbon_length_for_dimensions(dimensions) do
    for_the_smallest_side(dimensions) + for_the_bow(dimensions)
  end

  def for_the_smallest_side(dimensions) do
    [x, y, _] = Enum.sort(dimensions)
    x + x + y + y
  end

  def for_the_bow([x,y,z]), do: x*y*z

  defp to_int!(string) do
    {i, ""} = Integer.parse(string)
    i
  end

  defp answer_as_string(number), do: "#{number}"

end
