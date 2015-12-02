[
  {"Day Two - Part ii:", CodeAdvent.DayTwo.PartTwo},
  {"Day Two - Part 1:", CodeAdvent.DayTwo.PartOne},
  {"Day one - Part Deux:", CodeAdvent.DayOne.PartTwo},
  {"Day one - Part One:", CodeAdvent.DayOne.PartOne}
]
  |> Stream.map(fn {intro, module} -> {intro, module.run()} end)
  |> Stream.map(fn {intro, result} -> intro <> " " <> result end)
  |> Stream.each(&IO.puts/1)
  |> Enum.take 2
