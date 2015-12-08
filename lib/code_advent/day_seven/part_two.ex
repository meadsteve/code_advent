defmodule CodeAdvent.DaySeven.PartTwo do
  alias CodeAdvent.DaySeven.PartOne
  alias CodeAdvent.DaySeven.PartOne.CircuitRunner

  def run() do
    circuit = PartOne.get_running_circuit
    a = circuit |> CircuitRunner.wire(:a)

    circuit
      |> CircuitRunner.reset_circuit()
      |> CircuitRunner.force_value(:b, a)
      |> CircuitRunner.wire(:a)
      |> answer_as_string
  end

  def answer_as_string(result) do
    "#{inspect result}"
  end

end
