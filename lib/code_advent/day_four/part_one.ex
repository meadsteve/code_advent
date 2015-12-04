defmodule CodeAdvent.DayFour.PartOne do

  @batch_size 500

  def run(), do: run("iwrupvqb", seed: 0, target_zeros: 5)

  def run(input, seed: x, target_zeros: target_zeros) do
    input
      |> loop(seed: x, target_zeros: target_zeros)
      |> answer_as_string
  end

  defp loop(string, seed: x, target_zeros: target_zeros) do
    goal_string = 1 .. target_zeros
      |> Enum.map(fn _ -> "0" end)
      |> Enum.join
    loop(string, x, goal_string)
  end

  defp loop(string, value, goal_start_string) do
    receive do
      {:answer, value}  -> value
     after
       0_001 ->
         check_values(string, value .. (value + @batch_size), goal_start_string)
         loop(string, value + @batch_size, goal_start_string)
     end
  end

  defp check_values(string, values, goal_start_string) do
    resond_to = self
    spawn_link fn ->
      Enum.each(values, &check_md5(&1, string, goal_start_string, resond_to))
    end
    send resond_to, {:nope}
  end

  defp check_md5(value, string, goal_start_string, resond_to) do
    hash = md5("#{string}#{value}")
    if hash |> String.starts_with?(goal_start_string) do
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
