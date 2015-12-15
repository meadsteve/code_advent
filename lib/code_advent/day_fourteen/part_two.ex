defmodule CodeAdvent.DayFourteen.PartTwo do
  @file_path "lib/code_advent/day_fourteen/input_data.txt"
  @input_pattern ~r/(?<name>[a-z]+) can fly (?<speed>[0-9]+) km\/s for (?<time_at_speed>[0-9]+) seconds, but then must rest for (?<time_at_rest>[0-9]+) seconds\./i

  defmodule Reindeer do
    defstruct name: "Bob",
              speed: 0,
              time_at_speed: 1,
              time_at_rest: 1,
              distance_covered: 0,
              sprint_left: 0,
              rest_left: 0,
              points: 0
  end

  def run() do
    deer = @file_path
      |> File.read!
      |> String.split("\n", trim: true)
      |> Enum.map(&parse/1)

    [winning_score] = 1..2503
      |> Enum.reduce(deer, &run_all_deer/2)
      |> Stream.map(fn single_deer -> single_deer.points end)
      |> Enum.take(1)

    winning_score |> as_string
  end

  def parse(line) do
    input = Regex.named_captures(@input_pattern, line)
    %Reindeer{
      name: input["name"],
      speed: input["speed"] |> to_int!,
      time_at_speed: input["time_at_speed"] |> to_int!,
      sprint_left: input["time_at_speed"] |> to_int!,
      time_at_rest: input["time_at_rest"] |> to_int!
    }
  end

  def run_all_deer(_, deers) do
    deers
      |> Enum.map(&increment_single_deer/1)
      |> add_point_to_top_deer
  end

  def increment_single_deer(deer) do
    cond do
      deer.sprint_left > 0 -> run_deer(deer)
      deer.rest_left > 0   -> rest_deer(deer)
    end
  end

  def add_point_to_top_deer(deers) do
    [top_deer | rest] = deers
      |> Enum.sort(fn (a,b) -> a.distance_covered > b.distance_covered end)
    [%Reindeer{top_deer | points: top_deer.points + 1}| rest]
  end

  defp run_deer(deer) do
    moved_deer = %Reindeer{ deer |
      distance_covered: deer.distance_covered + deer.speed,
      sprint_left: deer.sprint_left - 1
    }
    if moved_deer.sprint_left == 0 do
      %Reindeer{ moved_deer | rest_left: moved_deer.time_at_rest}
    else
      moved_deer
    end
  end

  defp rest_deer(deer) do
    rested_deer = %Reindeer{ deer |
      rest_left: deer.rest_left - 1
    }
    if rested_deer.rest_left == 0 do
      %Reindeer{ rested_deer | sprint_left: rested_deer.time_at_speed}
    else
      rested_deer
    end
  end

  defp to_int!(string) do
    {int, ""} = Integer.parse(string)
    int
  end

  defp as_string(n), do: "#{n}"

  defp debug(thing) do
    IO.puts "#{inspect thing}"
    thing
  end
end