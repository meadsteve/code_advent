defmodule DayElevenTest do
  use ExUnit.Case
  alias CodeAdvent.DayEleven.PartOne
  alias CodeAdvent.DayEleven.Validator


  test "Increments last char in passwords" do
    assert PartOne.increment("era") == "erb"
  end

  test "z wraps around to a and increments" do
    assert PartOne.increment("ebz") == "eca"
  end

  test "z wraps around to a and increments as many times as needed" do
    assert PartOne.increment("ezz") == "faa"
  end

  test "validator requires 3 increasing chars" do
    assert Validator.has_sequence?('bcd') == true
    assert Validator.has_sequence?('bce') == false
  end

  test "fails validation if bad char is found" do
    assert Validator.contains_bad_chars?('bcdi') == true
    assert Validator.contains_bad_chars?('obce') == true
    assert Validator.contains_bad_chars?('bcel') == true
  end

  test "requires different double pairs" do
    assert Validator.has_two_pairs?('aabcdii') == true
  end

end
