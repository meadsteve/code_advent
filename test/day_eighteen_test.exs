defmodule DayEighteenTest do
  use ExUnit.Case
  alias CodeAdvent.DayEighteen.Grid
  alias CodeAdvent.DayEighteen.Switcher
  alias CodeAdvent.DayEighteen.Parser
  alias CodeAdvent.DayEighteen.Runner

  test "Grid values can be accessed by x & y and start :off" do
    value = Grid.new
      |> Grid.get(5, 5)
    assert value == :off
  end

  test "Grid values can have their value set" do
    value = Grid.new
      |> Grid.set(5, 5, :on)
      |> Grid.get(5, 5)
    assert value == :on
  end

  test "Grid values over a boundary are off" do
    value = Grid.new
      |> Grid.set(0, 0, :on)
      |> Grid.get(100, 0)
    assert value == :off
  end

  test "Grid values under a boundary are off" do
    value = Grid.new
      |> Grid.set(0, 99, :on)
      |> Grid.get(0, -1)
    assert value == :off
  end

  test "Grid can be queried for neighbours values" do
    neighbours = Grid.new
      |> Grid.set(4, 5, :on)
      |> Grid.set(5, 4, :on)
      |> Grid.get_neighbours(4, 4)

    on_neighbours = neighbours |> Enum.filter(&(&1 == :on)) |> Enum.count
    off_neighbours = neighbours |> Enum.filter(&(&1 == :off)) |> Enum.count
    assert on_neighbours == 2
    assert off_neighbours == 6
  end

  test ":on light with two :on neighbours stays on" do
    grid = Grid.new
      |> Grid.set(4, 5, :on)
      |> Grid.set(5, 4, :on)
      |> Grid.set(4, 4, :on)

    assert Switcher.next_value(grid, 4, 4) == :on
  end

  test ":on light with three :on neighbours stays on" do
    grid = Grid.new
      |> Grid.set(4, 5, :on)
      |> Grid.set(5, 4, :on)
      |> Grid.set(3, 4, :on)
      |> Grid.set(4, 4, :on)

    assert Switcher.next_value(grid, 4, 4) == :on
  end

  test ":on light with four :on neighbours switches :off" do
    grid = Grid.new
      |> Grid.set(4, 5, :on)
      |> Grid.set(5, 4, :on)
      |> Grid.set(3, 4, :on)
      |> Grid.set(4, 3, :on)
      |> Grid.set(4, 4, :on)

    assert Switcher.next_value(grid, 4, 4) == :off
  end

  test ":off light with three :on neighbours switches on" do
    grid = Grid.new
      |> Grid.set(4, 5, :on)
      |> Grid.set(5, 4, :on)
      |> Grid.set(3, 4, :on)
      |> Grid.set(4, 4, :off)

    assert Switcher.next_value(grid, 4, 4) == :on
  end

  test "parser returns expected grid" do
    input = """
    .#.#.#
    ...##.
    #....#
    ..#...
    #.#..#
    ####..
    """
    grid = Parser.parse(input)

    assert Grid.get(grid, 0, 0) == :off
    assert Grid.get(grid, 1, 0) == :on
    assert Grid.get(grid, 3, 1) == :on

  end

  test "Runner produces the example given" do
    starting_string = """
    .#.#.#
    ...##.
    #....#
    ..#...
    #.#..#
    ####..
    """
    step_one_string = """
    ..##..
    ..##.#
    ...##.
    ......
    #.....
    #.##..
    """
    starting_grid = Parser.parse(starting_string)
    step_one_grid = Parser.parse(step_one_string)

    assert Runner.next(starting_grid) == step_one_grid
  end

end
