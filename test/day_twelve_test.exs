defmodule DayTwelveTest do
  use ExUnit.Case
  alias CodeAdvent.DayTwelve.PartOne
  alias CodeAdvent.DayTwelve.PartTwo


  test "sum json arrays [1,2,3]" do
    assert PartOne.sum_line("[1,2,3]") == 6
  end

  test "sum json literal objects {a:2,b:4}" do
    ob_string = """
    {"a":2,"b":4}
    """
    assert PartOne.sum_line(ob_string) == 6
  end

  test "values are popped from nested arrays" do
    assert PartOne.sum_line("[[[3]]]") == 3
  end

  test "values are popped from nested literals" do
    string = """
    {"a":{"b":4},"c":-1}
    """
    assert PartOne.sum_line(string) == 3
  end

  test "strings are zero" do
    ob_string = """
    {"a":2,"b":4,"c":"lemon"}
    """
    assert PartOne.sum_line(ob_string) == 6
  end

  test "objects with red are red" do
    string = """
    {"c":"red","b":2}
    """ |> PartOne.parse_line

    assert PartTwo.is_red?(string) == true
  end

  test "parent objects are not red" do
    string = """
    [1,{"c":"red","b":2},3]
    """ |> PartOne.parse_line

    assert PartTwo.is_red?(string) == false
  end

end
