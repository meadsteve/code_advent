defmodule CodeAdvent.DaySeven.PartOne.CircuitRunner do
  @max_stack 100

  def wire(%{} = circuit, wire_label) when is_atom(wire_label) do
    pid = circuit |> Dict.get(wire_label)
    send pid, {:get_value, self(), circuit}
    receive do
      {:value, value} -> value
    end
  end

  def start_circuit(%{} = circuit) do
    circuit
    |> Enum.map(fn {key, %{component_func: func}} ->
      {key, run_unknown_circuit(func)}
    end)
    |> Enum.into(%{})
  end

  def reset_circuit(%{} = circuit) do
    circuit
      |> Enum.each(fn {key, pid} ->
        send pid, {:reset}
      end)
    circuit
  end

  def force_value(%{} = circuit, key, value) do
    pid = circuit[key]
    send pid, {:replace_value, value}
    circuit
  end

  def run_unknown_circuit(load_fn) do
    spawn_link fn -> running_unknown_circuit(load_fn) end
  end

  def running_unknown_circuit(load_fn) do
    receive do
      {:reset} ->
        running_unknown_circuit(load_fn)
      {:replace_value, new_value} ->
        running_known_circuit({new_value, load_fn})
      {:get_value, sender, circuit} ->
        value = load_fn.(circuit)
        send sender, {:value, value}
        running_known_circuit({value, load_fn})
    end
  end

  def running_known_circuit({value, load_fn}) do
    receive do
      {:get_value, sender, circuit} ->
        send sender, {:value, value}
        running_known_circuit({value, load_fn})
      {:reset} ->
        run_unknown_circuit(load_fn)
      {:replace_value, new_value} ->
        running_known_circuit({new_value, load_fn})
    end
  end

end
