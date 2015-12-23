defmodule CodeAdvent.DayTwenty.PartOne do

  @target_presents 29000000

  def run() do
    @target_presents
      |> find_min_house_with_presents
      |> as_string
  end

  def find_min_house_with_presents(presents) do
    [{_, house}] = house_stream
      |> Stream.with_index
      |> Stream.filter(fn {present, _} -> present >= presents end)
      |> Enum.take(1)
    house + 1
  end

  def house_stream do
    Stream.unfold(1, fn
      n -> {present_count(house_number: n), n + 1}
    end)
  end

  def present_count(house_number: n) do
    present_count(0, house_number: n, elf_number: n)
  end

  defp present_count(total, house_number: _, elf_number: 1) do
    total + 10
  end

  defp present_count(total, house_number: house, elf_number: elf) do
    new_total = if (house |> rem elf) == 0 do
      total + (elf * 10)
    else
      total
    end
    present_count(new_total, house_number: house, elf_number: elf - 1)
  end

  defp as_string(n), do: "#{n}"
end
