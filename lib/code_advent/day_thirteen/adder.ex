defmodule CodeAdvent.DayThirteen.Adder do
  alias CodeAdvent.DayThirteen.Parser

  def add_ambivalent_self(data) do
    hapiness = data.people
      |> Enum.reduce(data.hapiness, &add_ambivalent_entry/2)
      %{data | hapiness: hapiness, people: ["me" | data.people]}
  end

  defp add_ambivalent_entry(name, happy_map) do
    forward = %{"amount" => "0", "person" => "me", "neighbour" => name}
    back    = %{"amount" => "0", "person" => name, "neighbour" => "me"}
    happy_map
      |> Parser.add_hapiness_entry(forward)
      |> Parser.add_hapiness_entry(back)
  end



end
