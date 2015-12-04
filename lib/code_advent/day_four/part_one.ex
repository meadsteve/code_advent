defmodule CodeAdvent.DayFour.PartOne do

  @batch_size 500

  def run(), do: run("iwrupvqb", seed: 0)

  def run(input, seed: x) do
    input
      |> loop(seed: x)
      |> answer_as_string
  end

  defp loop(string), do: loop(string, 0)
  defp loop(string, seed: x), do: loop(string, x)

  defp loop(string, value) do
    receive do
      {:answer, value}  -> value
     after
       0_001 ->
         check_values(string, value .. value + @batch_size)
         loop(string, value + @batch_size)
     end
  end

  defp check_values(string, values) do
    resond_to = self
    spawn_link fn ->
      Enum.each(values, &check_md5(&1, string, resond_to))
    end
  end

  defp check_md5(value, string, resond_to) do
    hash = md5("#{string}#{value}")
    if hash |> String.starts_with?("00000") do
      send resond_to, {:answer, value}
    end
  end

  # md5 implementation stolen from
  # http://www.elixirdose.com/post/Phoenix%20Part%204
  def md5(string) do
    :crypto.hash(:md5, string)
      |> :erlang.bitstring_to_list
      |> Enum.map(&(:io_lib.format("~2.16.0b", [&1])))
      |> List.flatten
      |> :erlang.list_to_bitstring
  end

  defp answer_as_string(thing) do
    "#{thing}"
  end
end
