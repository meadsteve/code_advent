defmodule DaySevenTest do
  use ExUnit.Case

  @simple_example """
  123 -> x
  456 -> y
  x AND y -> d
  1 AND y -> b
  x OR y -> e
  x LSHIFT 2 -> f
  y RSHIFT 2 -> g
  NOT x -> h
  NOT y -> i
  x -> z
  d -> a
  """

  test "always returns a map of wires" do
    circuit = CodeAdvent.DaySeven.PartOne.build_circuit(@simple_example)
    assert circuit
      |> has_keys?([:x, :y, :d, :e, :f, :g, :h, :i])

  end

  test "Wires with numeric left hand side return that value" do
    assert @simple_example
      |> CodeAdvent.DaySeven.PartOne.build_circuit()
      |> CodeAdvent.DaySeven.PartOne.CircuitRunner.wire(:x)
    == 123
  end

  test "And gates work" do
    use Bitwise
    assert @simple_example
      |> CodeAdvent.DaySeven.PartOne.build_circuit()
      |> CodeAdvent.DaySeven.PartOne.CircuitRunner.wire(:d)
    == (123 |> band(456))
  end

  test "And gates work with partly numeric input" do
    use Bitwise
    assert @simple_example
      |> CodeAdvent.DaySeven.PartOne.build_circuit()
      |> CodeAdvent.DaySeven.PartOne.CircuitRunner.wire(:b)
    == (1 |> band(456))
  end

  test "or gates work" do
    use Bitwise
    assert @simple_example
      |> CodeAdvent.DaySeven.PartOne.build_circuit()
      |> CodeAdvent.DaySeven.PartOne.CircuitRunner.wire(:e)
    == (123 |> bor(456))
  end

  test "lshift gates work" do
    use Bitwise
    assert @simple_example
      |> CodeAdvent.DaySeven.PartOne.build_circuit()
      |> CodeAdvent.DaySeven.PartOne.CircuitRunner.wire(:f)
    == (123 |> bsl(2))
  end

  test "not gates work" do
    use Bitwise
    assert @simple_example
      |> CodeAdvent.DaySeven.PartOne.build_circuit()
      |> CodeAdvent.DaySeven.PartOne.CircuitRunner.wire(:h)
    == (123 |> bnot)
  end

  test "linking wrires work" do
    assert @simple_example
      |> CodeAdvent.DaySeven.PartOne.build_circuit()
      |> CodeAdvent.DaySeven.PartOne.CircuitRunner.wire(:z)
    == 123
  end

  test "multi steps" do
    use Bitwise
    assert @simple_example
      |> CodeAdvent.DaySeven.PartOne.build_circuit()
      |> CodeAdvent.DaySeven.PartOne.CircuitRunner.wire(:a)
    == (123 |> band(456))
  end

  test "Gives expected results for sample input" do
    use Bitwise
    circuit = @simple_example
      |> CodeAdvent.DaySeven.PartOne.build_circuit()

    assert CodeAdvent.DaySeven.PartOne.CircuitRunner.wire(circuit, :d) == 72
    assert CodeAdvent.DaySeven.PartOne.CircuitRunner.wire(circuit, :e) == 507
    assert CodeAdvent.DaySeven.PartOne.CircuitRunner.wire(circuit, :f) == 492
    assert CodeAdvent.DaySeven.PartOne.CircuitRunner.wire(circuit, :g) == 114
    assert CodeAdvent.DaySeven.PartOne.CircuitRunner.wire(circuit, :h) == 65412
    assert CodeAdvent.DaySeven.PartOne.CircuitRunner.wire(circuit, :i) == 65079
    assert CodeAdvent.DaySeven.PartOne.CircuitRunner.wire(circuit, :x) == 123
    assert CodeAdvent.DaySeven.PartOne.CircuitRunner.wire(circuit, :y) == 456
  end

  defp has_keys?(dict, keys) do
    keys
      |> Enum.map(&Dict.has_key?(dict, &1))
      |> Enum.all?(fn has_key? -> has_key? == true end)
  end
end
