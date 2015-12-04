defmodule DayFourTest do
  use ExUnit.Case

  test "hashing works" do
    hash = CodeAdvent.DayFour.PartOne.md5("abcdef609043")
    assert hash == "000001dbbfa3a5c83a2d506429c7b00e"
  end

  @tag timeout: 5 * 60000
  test "can find results with the first example" do
    assert CodeAdvent.DayFour.PartOne.run("abcdef", seed: 600043) == "609043"
  end

  @tag timeout: 5 * 60000
  test "can find results with the second example" do
    assert CodeAdvent.DayFour.PartOne.run("pqrstuv", seed: 1000000) == "1048970"
  end

end
