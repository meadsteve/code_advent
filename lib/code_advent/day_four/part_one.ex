defmodule CodeAdvent.DayFour.PartOne do

  @batch_size 500
  @max_attempt 100000000

  def run(), do: run("iwrupvqb", seed: 0, target_zeros: 5)

  def run(input, seed: seed, target_zeros: target_zeros) do
    goal_start_string = target_zeros |> as_zeros

    [{answer, _}] = seed..@max_attempt
     |> Stream.map(fn(n) -> {n, md5("#{input}#{n}")} end)
     |> Stream.filter(&starts_with?(&1, goal_start_string))
     |> Enum.take(1)

    answer
      |> answer_as_string
  end

  defp as_zeros(target_zeros) do
    1 .. target_zeros
      |> Enum.map(fn _ -> "0" end)
      |> Enum.join
  end

  defp starts_with?({_, md5_string}, goal_start_string) do
    String.starts_with?(md5_string, goal_start_string)
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
