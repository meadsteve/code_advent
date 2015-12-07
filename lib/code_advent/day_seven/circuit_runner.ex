defmodule CodeAdvent.DaySeven.PartOne.CircuitRunner do
  @max_stack 100

  def wire(%{} = circuit, wire_label) when is_atom(wire_label) do
    pid = circuit |> Dict.get(wire_label)
    send pid, {:get_value, self(), circuit}
    receive do
      {:value, value} -> value
    end
  end

  defp get_func(%{component_func: func}, wire_label) do
    func
  end

  defp get_func(bad_thing, wire_label) do
    IO.puts "Got a bad thing: #{inspect bad_thing} when loading #{inspect wire_label}"
    fn(_) -> nil end
  end

  def start_circuit(%{} = circuit) do
    circuit
    |> Enum.map(fn {key, %{component_func: func}} ->
      {key, run_unknown_circuit(func)}
    end)
    |> Enum.into(%{})
  end

  def run_unknown_circuit(load_fn) do
    spawn fn ->
      receive do
        {:get_value, sender, circuit} ->
          value = load_fn.(circuit)
          send sender, {:value, value}
          running_known_circuit(value)
      end
    end
  end

  def running_known_circuit(value) do
    receive do
      {:get_value, sender, circuit} ->
        send sender, {:value, value}
        running_known_circuit(value)
    end
  end

end
