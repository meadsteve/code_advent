defmodule CodeAdvent.DayTwo.PartOne do
  @file_path "lib/code_advent/day_two/input_data.txt"

  def run() do
    @file_path
      |> File.read!
      |> String.split
      |> Enum.map(&get_dimensions/1)
      |> Enum.map(&get_total_square_footage_for_dimensions/1)
      |> Enum.sum
      |> answer_as_string
  end

  defp get_dimensions(string) do
    string
      |> String.split("x")
      |> Enum.map(&to_int!/1)
  end

  defp get_total_square_footage_for_dimensions(dimensions) do
    total_surface_area(dimensions) + smallest_area(dimensions)
  end

  defp total_surface_area([l, w, h]), do: 2*l*w + 2*w*h + 2*h*l
  defp smallest_area(dimensions) do
    [x, y, _] = Enum.sort(dimensions)
    x * y
  end

  defp to_int!(string) do
    {i, ""} = Integer.parse(string)
    i
  end

  defp answer_as_string(number), do: "#{number}"

end
