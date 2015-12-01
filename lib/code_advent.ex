[
  {"Day one:", CodeAdvent.DayOne.Solve}
]
  |> Enum.map(fn {intro, module} -> {intro, module.run()} end)
  |> Enum.map(fn {intro, result} -> intro <> " " <> result end)
  |> Enum.each(&IO.puts/1)
