defmodule CodeAdvent.DaySix.PartTwo do
  @file_path "lib/code_advent/day_six/input_data.txt"

  def run() do
    @file_path
      |> File.read!
      |> run
  end

  def run (string) do
    string
      |> String.split("\n")
      |> Enum.reduce(new_light_map, &apply_instruction/2)
      |> Enum.reduce(0, &add_brightness/2)
      |> answer_as_string
  end

  defp new_light_map() do
    Map.new
      |> apply_function_to_range(&set_light_off/2, [[0, 0], [999, 999]])
  end

  defp apply_instruction("turn on " <> range, %{} = lights) do
    lights
      |> apply_function_to_range(&set_light_on/2, range)
  end

  defp apply_instruction("turn off " <> range, %{} = lights) do
    lights
      |> apply_function_to_range(&set_light_off/2, range)
  end

  defp apply_instruction("toggle " <> range, %{} = lights) do
    lights
      |> apply_function_to_range(&toggle_light/2, range)
  end

  defp apply_instruction(_skipped, %{} = lights) do
    lights
  end

  defp apply_function_to_range(lights, funct, [[x1, y1], [x2, y2]]) do
    for x <- x1..x2, y <- y1..y2 do
      {x, y}
    end |> Enum.reduce(lights, funct)
  end

  defp apply_function_to_range(lights, funct, range) do
    apply_function_to_range(lights, funct, get_range_coords(range))
  end

  defp set_light_on({x, y}, %{} = lights) do
    Map.update!(lights, x + 1000 * y, &on/1)
  end

  defp set_light_off({x, y}, %{} = lights) do
    Map.update(lights, x + 1000 * y, 0, &off/1)
  end

  defp toggle_light({x, y}, %{} = lights) do
    Map.update!(lights, x + 1000 * y, &toggle/1)
  end

  defp toggle(x), do: x + 2
  defp on(x),     do: x + 1
  defp off(0),    do: 0
  defp off(x),    do: x - 1

  defp add_brightness({_, light_brightness}, total_brightness) do
    total_brightness + light_brightness
  end

  defp get_range_coords(instruction) do
    instruction
      |> String.split(" through ")
      |> Enum.map(&String.split(&1, ","))
      |> Enum.map(fn pair -> Enum.map(pair, &parse_int!/1)  end)
  end

  defp parse_int!(string) do
    {n, ""} = Integer.parse(string)
    n
  end

  defp answer_as_string(number), do: "#{number}"
end
