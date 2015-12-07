defmodule CodeAdvent.DaySeven.PartOne do
  alias CodeAdvent.DaySeven.PartOne.WireFunctions
  alias CodeAdvent.DaySeven.PartOne.CircuitRunner

  @file_path "lib/code_advent/day_seven/input_data.txt"
  @wire_line ~r/(?<component>[^-]+) -> (?<label>[a-z]+)/i

  defmodule Wire do
    defstruct label: nil,
              full_line: "",
              component_func: nil
  end

  def run() do
    @file_path
      |> File.read!
      |> build_circuit
      |> CircuitRunner.start_circuit
      |> CircuitRunner.wire(:a)
      |> answer_as_string
  end

  def build_circuit(string) do
    string
      |> String.split("\n", trim: true)
      |> Enum.map(&to_wires/1)
      |> Enum.reduce(%{}, &add_wire_to_circuit/2)
  end

  defp to_wires(line) do
    %{"label" => label, "component" => component} = @wire_line
      |> Regex.named_captures(line)
    %Wire{
      label: String.to_atom(label),
      component_func: WireFunctions.get(component),
      full_line: line
    }
  end

  defp add_wire_to_circuit(%Wire{label: label} = wire, circuit) do
    circuit |> Dict.put(label, wire)
  end

  defp debug(thing) do
    IO.puts "#{inspect thing.a}"
    thing
  end

  def answer_as_string(result) do
    "#{inspect result}"
  end

end
