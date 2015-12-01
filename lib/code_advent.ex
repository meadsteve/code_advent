[
  {"Day one:", CodeAdvent.DayOne.Solve}
]
  |> Stream.map(fn {intro, module} -> {intro, module.run()} end)
  |> Stream.map(fn {intro, result} -> intro <> " " <> result end)
  |> Stream.each(&IO.puts/1)
  |> Enum.take 1
