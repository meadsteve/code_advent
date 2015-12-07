defmodule CodeAdvent.DaySeven.PartOne.WireFunctions do
  alias CodeAdvent.DaySeven.PartOne.CircuitRunner
  @numeric_value ~r/^[0-9]+$/i
  @alpha_value ~r/^[a-z]+$/i

  @and_gate ~r/^.+ AND .+$/i
  @or_gate ~r/^.+ OR .+$/i
  @lshift_gate ~r/^.+ LSHIFT .+$/i
  @rshift_gate ~r/^.+ RSHIFT .+$/i
  @not_gate ~r/^NOT .+$/i

  def get(string) do
    cond do
      Regex.match?(@and_gate, string) ->
        build_and_func(string)
      Regex.match?(@or_gate, string) ->
        build_or_func(string)
      Regex.match?(@lshift_gate, string) ->
        build_lshift_func(string)
      Regex.match?(@rshift_gate, string) ->
        build_rshift_func(string)
      Regex.match?(@not_gate, string) ->
        build_not_func(string)
      true ->
        build_value_func(string)
    end
  end

  defp build_value_func(value) do
    thing = as_circuit_link(value)
    fn(circuit) -> thing.(circuit) end
  end

  defp build_and_func(string) do
    [left, right] = string
      |> left_and_right(" AND ")
    fn(circuit) ->
      use Bitwise
      left.(circuit)
        |> band(right.(circuit))
    end
  end

  defp build_or_func(string) do
    [left, right] = string
      |> left_and_right(" OR ")
    fn(circuit) ->
      use Bitwise
      left.(circuit)
        |> bor(right.(circuit))
    end
  end

  defp build_lshift_func(string) do
    [left, right] = string
      |> left_and_right(" LSHIFT ")
    fn(circuit) ->
      use Bitwise
      left.(circuit)
        |> bsl(right.(circuit))
    end
  end

  defp build_rshift_func(string) do
    [left, right] = string
      |> left_and_right(" RSHIFT ")
    fn(circuit) ->
      use Bitwise
      left.(circuit)
        |> bsr(right.(circuit))
    end
  end

  defp build_not_func("NOT " <> string) do
    input = as_circuit_link(string)
    fn(circuit) ->
      use Bitwise
      input.(circuit)
        |> bnot
    end
  end

  defp left_and_right(string, break_term) do
    string
      |> String.split(break_term)
      |> Enum.map(&as_circuit_link/1)
  end

  defp as_circuit_link(thing) do
    cond do
      is_numeric?(thing) ->
        fn(_) -> to_int!(thing) end
      is_alpha?(thing) ->
        link = String.to_atom(thing)
        fn(circuit) -> CircuitRunner.wire(circuit, link) end
      true ->
        raise "Could not create link for #{inspect thing}"
    end
  end

  defp is_numeric?(thing) do
    Regex.match?(@numeric_value, thing)
  end

  defp is_alpha?(thing) do
    Regex.match?(@alpha_value, thing)
  end

  defp to_int!(string) do
    {int, ""} = Integer.parse(string)
    int
  end

end
