defmodule DayNineteenTest do
  use ExUnit.Case
  alias CodeAdvent.DayNineteen.PartOne

  test "The last line of the input is the sarting string" do
    string = """
    H => HO
    H => OH
    O => HH

    HOH
    """
    data = PartOne.parse(string)
    assert data.goal_string == "HOH"
  end

  test "All replacements are loaded in to a map" do
    string = """
    H => HO
    H => OH
    O => HH

    HOH
    """
    data = PartOne.parse(string)
    assert data.replacements["O"] == ["HH"]
    assert data.replacements["H"] == ["HO", "OH"]
    assert data.replacements[""] == nil
  end

  test "Runs the first example correctly" do
    string = """
    H => HO
    H => OH
    O => HH

    HOH
    """
    molecules = string
      |> PartOne.parse
      |> PartOne.calibrate
    assert Enum.count(molecules) == 4
  end

  test "Runs the second example correctly" do
    string = """
    H => HO
    H => OH
    O => HH

    HOHOHO
    """
    molecules = string
      |> PartOne.parse
      |> PartOne.calibrate
    assert Enum.count(molecules) == 7
  end

  test "non matching replacements don't affect the results" do
    string = """
    H => HO
    H => OH
    O => HH
    Z => OD

    HOHOHO
    """
    molecules = string
      |> PartOne.parse
      |> PartOne.calibrate
    assert Enum.count(molecules) == 7
  end


end
