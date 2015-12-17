defmodule CodeAdvent.DaySeventeen.PartTwo do
  alias CodeAdvent.DaySeventeen.PartOne

  def run() do
    [shortest] = PartOne.get_container_options_from_file
      |> Enum.map(&Enum.count/1)
      |> Enum.sort
      |> Enum.take(1)

    shortest |> answer_as_string
  end

  defp answer_as_string(number), do: "#{number}"
end
