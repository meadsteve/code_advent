defmodule CodeAdvent.DaySixteen.PartOne do
  @file_path "lib/code_advent/day_sixteen/input_data.txt"
  @input_pattern ~r/(?<name>[a-z 0-9]+): (?<facts>.+)/i

  defmodule Aunt do
    defstruct name: "Bob",
              facts: []
  end

  def run() do
    data = @file_path
      |> File.read!
      |> String.split("\n", trim: true)
      |> Enum.each(&parse/1)

    :ok |> as_string
  end

  def parse(line) do
    data = Regex.named_captures(@input_pattern, line)
    facts = data["facts"]
      |> String.split(", ", trim: true)
      |> Enum.map(fn fact -> String.split(fact, ": ") end)
      |> Enum.map(fn [thing, count] -> {thing, count |> to_int!} end)
    %Aunt{
      name: data["name"],
      facts: facts
    }
  end

  defp to_int!(string) do
    {int, ""} = Integer.parse(string)
    int
  end

  defp as_string(n), do: "#{n}"
end
