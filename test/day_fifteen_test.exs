defmodule DayFourteenTest do
  use ExUnit.Case
  alias CodeAdvent.DayFourteen.PartOne
  alias CodeAdvent.DayFourteen.PartTwo

  test "correct when less than time at speed" do
    reindeer = %PartOne.Reindeer{
      speed: 1,
      time_at_speed: 10,
    }
    assert PartOne.distance_travelled(reindeer, 5) == 5
  end

  test "caps when reindeer are resting" do
    reindeer = %PartOne.Reindeer{
      speed: 1,
      time_at_speed: 10,
      time_at_rest: 5
    }
    assert PartOne.distance_travelled(reindeer, 13) == 10
  end

  test "After a break they start running again" do
    reindeer = %PartOne.Reindeer{
      speed: 1,
      time_at_speed: 10,
      time_at_rest: 5
    }
    assert PartOne.distance_travelled(reindeer, 16) == 11
  end

  test "Creates reindeer from strings" do
    input = """
    Vixen can fly 19 km/s for 7 seconds, but then must rest for 124 seconds.
    """
    assert PartOne.parse(input) == %PartOne.Reindeer{
      name: "Vixen",
      speed: 19,
      time_at_speed: 7,
      time_at_rest: 124
    }
  end

  test "increment_single_deer pushes them 1 second forward when running" do
    reindeer = %PartTwo.Reindeer{
      speed: 1,
      time_at_speed: 10,
      time_at_rest: 5,
      distance: 0,
      sprint_left: 10,
      rest_left: 0
    }
    assert PartTwo.increment_single_deer(reindeer) == %PartTwo.Reindeer{
      speed: 1,
      time_at_speed: 10,
      time_at_rest: 5,
      distance: 1,
      sprint_left: 9,
      rest_left: 0
    }
  end

  test "incremented deer start resting" do
    reindeer = %PartTwo.Reindeer{
      speed: 1,
      time_at_speed: 10,
      time_at_rest: 5,
      distance: 0,
      sprint_left: 1,
      rest_left: 0
    }
    assert PartTwo.increment_single_deer(reindeer) == %PartTwo.Reindeer{
      speed: 1,
      time_at_speed: 10,
      time_at_rest: 5,
      distance: 1,
      sprint_left: 0,
      rest_left: 5
    }
  end

  test "resting deer don't move" do
    reindeer = %PartTwo.Reindeer{
      speed: 1,
      time_at_speed: 10,
      time_at_rest: 5,
      distance: 0,
      sprint_left: 0,
      rest_left: 5
    }
    assert PartTwo.increment_single_deer(reindeer) == %PartTwo.Reindeer{
      speed: 1,
      time_at_speed: 10,
      time_at_rest: 5,
      distance: 0,
      sprint_left: 0,
      rest_left: 4
    }
  end

  test "top deer can be given a point" do
    deers = [
      %PartTwo.Reindeer{name: "worst", distance: 2, points: 0},
      %PartTwo.Reindeer{name: "best", distance: 5, points: 0}
    ]
    assert PartTwo.add_point_to_top_deer(deers) == [
      %PartTwo.Reindeer{name: "best", distance: 5, points: 1},
      %PartTwo.Reindeer{name: "worst", distance: 2, points: 0}
    ]
  end

  test "tied top deer get points" do
    deers = [
      %PartTwo.Reindeer{name: "worst", distance: 2, points: 0},
      %PartTwo.Reindeer{name: "best", distance: 5, points: 0},
      %PartTwo.Reindeer{name: "best", distance: 5, points: 0}
    ]
    assert PartTwo.add_point_to_top_deer(deers) == [
      %PartTwo.Reindeer{name: "best", distance: 5, points: 1},
      %PartTwo.Reindeer{name: "best", distance: 5, points: 1},
      %PartTwo.Reindeer{name: "worst", distance: 2, points: 0}
    ]
  end

  @part_two_deer [
    %PartTwo.Reindeer{name: "Dancer",speed: 16, time_at_rest: 162, time_at_speed: 11, sprint_left: 11},
    %PartTwo.Reindeer{name: "Comet", speed: 14, time_at_rest: 127, time_at_speed: 10, sprint_left: 10}
  ]

  test "Comet gets their first point in the 2nd example at the 140th second" do
    [winner, loser] = PartTwo.ordered_deer_after(@part_two_deer, 140)

    assert winner.name == "Dancer"
    assert winner.points == 139
    assert loser.name == "Comet"
    assert loser.points == 1

  end

  @tag :old_still_failing
  test "second part example returns expected results" do
    [winner, loser] = PartTwo.ordered_deer_after(@part_two_deer, 1000)

    assert winner.name == "Dancer"
    assert winner.points == 689

    assert loser.name == "Comet"
    assert loser.points == 312

  end


end
