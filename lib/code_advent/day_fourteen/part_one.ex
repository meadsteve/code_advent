defmodule CodeAdvent.DayFourteen.PartOne do
  @file_path "lib/code_advent/day_fourteen/input_data.txt"
  @input_pattern ~r/(?<name>[a-z]+) can fly (?<speed>[0-9]+) km\/s for (?<time_at_speed>[0-9]+) seconds, but then must rest for (?<time_at_rest>[0-9]+) seconds\./i

  defmodule Reindeer do
    defstruct name: "Bob",
              speed: 0,
              time_at_speed: 1,
              time_at_rest: 1
  end

  def run() do
    [winning_distance] = @file_path
      |> File.read!
      |> String.split("\n", trim: true)
      |> Enum.map(&parse/1)
      |> Enum.map(&distance_travelled(&1, 2503))
      |> Enum.sort(&(&1 > &2))
      |> Enum.take(1)

    winning_distance |> as_string
  end

  def parse(line) do
    input = Regex.named_captures(@input_pattern, line)
    %Reindeer{
      name: input["name"],
      speed: input["speed"] |> to_int!,
      time_at_speed: input["time_at_speed"] |> to_int!,
      time_at_rest: input["time_at_rest"] |> to_int!
    }
  end

  def distance_travelled(%Reindeer{} = reindeer, time) when is_integer(time) do
    distance(
      reindeer,
      time_left: time,
      sprint_left: reindeer.time_at_speed,
      total: 0
    )
  end

  def distance(reindeer, time_left: time, sprint_left: sprint_left, total: total)
  when time <= sprint_left do
    total + time * reindeer.speed
  end

  def distance(reindeer, time_left: time, sprint_left: sprint_left, total: total)
  when time > sprint_left do
    distance_covered = sprint_left * reindeer.speed
    distance(
      reindeer,
      time_left: time - sprint_left,
      rest_left: reindeer.time_at_rest,
      total: total + distance_covered)
  end

  def distance(reindeer, time_left: time, rest_left: rest_left, total: total)
  when time <= rest_left do
    total
  end

  def distance(reindeer, time_left: time, rest_left: rest_left, total: total)
  when time > rest_left do
    distance(
      reindeer,
      time_left: time - rest_left,
      sprint_left: reindeer.time_at_speed,
      total: total
    )
  end

  defp to_int!(string) do
    {int, ""} = Integer.parse(string)
    int
  end

  defp as_string(n), do: "#{n}"
end
