defmodule DaySixTest do
  use ExUnit.Case


  test "can switch on all lights from a single instruction" do
    instruction = "turn on 0,0 through 999,999"
    assert CodeAdvent.DaySix.PartOne.run(instruction) == "#{1000 * 1000}"
  end

  test "can toggle off some lights" do
    instruction = """
    turn on 0,0 through 999,999
    toggle 0,0 through 999,0
    """
    assert CodeAdvent.DaySix.PartOne.run(instruction) == "#{(1000 * 1000) - 1000}"
  end

  test "can turn off some lights" do
    instruction = """
    turn on 0,0 through 999,999
    toggle 0,0 through 999,0
    turn off 0,0 through 0,4
    """
    assert CodeAdvent.DaySix.PartOne.run(instruction) == "#{(1000 * 1000) - 1000 - 4}"
  end

  test "more light switching on" do
    instruction = """
    turn on 0,0 through 999,0
    """
    assert CodeAdvent.DaySix.PartOne.run(instruction) == "#{1000}"
  end

end
