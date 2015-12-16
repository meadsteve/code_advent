[
  {"F+1 - 2", CodeAdvent.DaySixteen.PartTwo},
  {"F+1 - 1", CodeAdvent.DaySixteen.PartOne},
  {"15x2 ", CodeAdvent.DayFifteen.PartTwo},
  {"15x1 ", CodeAdvent.DayFifteen.PartOne},
  {"14 sub unit 2: ", CodeAdvent.DayFourteen.PartTwo},
  {"14 sub unit 1: ", CodeAdvent.DayFourteen.PartOne},
  {"13__2: ", CodeAdvent.DayThirteen.PartTwo},
  {"13__1: ", CodeAdvent.DayThirteen.PartOne},
  {"dozen 2: ", CodeAdvent.DayTwelve.PartTwo},
  {"dozen 1: ", CodeAdvent.DayTwelve.PartOne},
  {"11 - 2: ", CodeAdvent.DayEleven.PartTwo},
  {"11 - 1: ", CodeAdvent.DayEleven.PartOne},
  {"10.2: ", CodeAdvent.DayTen.PartTwo},
  {"10.1: ", CodeAdvent.DayTen.PartOne},
  {"9/2: ", CodeAdvent.DayNine.PartTwo},
  {"9/1: ", CodeAdvent.DayNine.PartOne},
  {"Eighth day of codemas part one: ", CodeAdvent.DayEight.PartOne},
  {"Day Seven - 2: ", CodeAdvent.DaySeven.PartTwo},
  {"Day Seven - 1: ", CodeAdvent.DaySeven.PartOne},
  {"Day Six - 2: ", CodeAdvent.DaySix.PartTwo},
  {"Day Six - 1: ", CodeAdvent.DaySix.PartOne},
  {"Day Five - 2: ", CodeAdvent.DayFive.PartTwo},
  {"Day Five - 1: ", CodeAdvent.DayFive.PartOne},
  {"Day Four - Part two santa coins: ", CodeAdvent.DayFour.PartTwo},
  {"Day Four - Part one santa coins: ", CodeAdvent.DayFour.PartOne},
  {"Day Three - Part 3-1:", CodeAdvent.DayThree.PartTwo},
  {"Day Three - Part 0+1:", CodeAdvent.DayThree.PartOne},
  {"Day Two - Part ii:", CodeAdvent.DayTwo.PartTwo},
  {"Day Two - Part 1:", CodeAdvent.DayTwo.PartOne},
  {"Day one - Part Deux:", CodeAdvent.DayOne.PartTwo},
  {"Day one - Part One:", CodeAdvent.DayOne.PartOne}
]
  |> Stream.map(fn {intro, module} -> {intro, module.run()} end)
  |> Stream.map(fn {intro, result} -> intro <> " " <> result end)
  |> Stream.each(&IO.puts/1)
  |> Enum.take(2)
