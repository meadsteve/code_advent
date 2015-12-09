defmodule CodeAdvent.DayNine.PartOne do
  @file_path "lib/code_advent/day_nine/input_data.txt"

  @input_pattern  ~r/^(?<orig>[a-z]+) to (?<dest>[a-z]+) = (?<distance>[0-9]+)/i
  @invalid_journey -1

  def run() do
    @file_path
      |> File.read!
      |> String.split("\n", trim: true)
      |> run
      |> answer_as_string
  end

  def run(strings) do
    data = Stream.map(strings, &to_data/1)

    distances = as_orig_to_dist_map(data)
    destinations = get_unique_destinations(distances)

    [best_destination] = destinations
      |> Permutations.of_list
      |> Enum.map(fn stops -> {journey_length(stops, distances), stops} end)
      |> Enum.filter(fn {length, _} -> length != @invalid_journey end)
      |> Enum.sort(fn({a,_}, {b,_}) -> a < b end)
      |> Enum.take(1)

    best_destination
  end

  defp to_data(line) do
    Regex.named_captures(@input_pattern, line)
  end

  defp get_unique_destinations(distances) do
    distances
      |> Enum.flat_map(fn {key, dests} -> Dict.keys(dests) end)
      |> Enum.concat(Dict.keys(distances))
      |> Enum.uniq
  end

  defp as_orig_to_dist_map(data) do
    data
      |> Enum.group_by(fn data -> data["orig"] end)
      |> Enum.map(fn {key, dests} -> {key, distances_by_dest(dests)} end)
      |> Enum.into(%{})
  end

  defp distances_by_dest(dests) do
    dests
      |> Enum.map(fn %{"dest" => dest, "distance" => distance} -> {dest, to_int!(distance)} end)
      |> Enum.into(%{})
  end

  defp journey_length(list, distances), do: journey_length(list, distances, 0)
  defp journey_length([_], distances, total), do: total
  defp journey_length([from, to | remaining], distances, total) do
    distance = distances |> distance_between(from, to)
    case distance do
      @invalid_journey ->
        IO.puts "invalid journey: #{from} -> #{to}"
        @invalid_journey
      _ ->
        journey_length([to | remaining], distances, total + distance)
    end
  end

  defp distance_between(distances, from, to) do
    cond  do
      Dict.has_key?(distances, from) && Dict.has_key?(distances[from], to) ->
        distances[from][to]
      Dict.has_key?(distances, to) && Dict.has_key?(distances[to], from) ->
        distances[to][from]
    end
  end

  defp to_int!(string) do
    {int, ""} = Integer.parse(string)
    int
  end

  defp answer_as_string(thing), do: "#{inspect thing}"
  defp debug(thing) do
    IO.puts "#{inspect thing}"
    thing
  end
end

defmodule Permutations do
  def of_list([]) do
    [[]]
  end

  # Ugly and probs slow but YOLO
  def of_list(list) do
    for h <- list, t <- of_list(list -- [h]), do: [h | t]
  end
end
