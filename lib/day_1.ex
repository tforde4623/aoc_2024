defmodule Problem1 do
  def part2 do
    # consolidate this file parsing logic
    column1 = []
    column2 = []

    {updated_col1, updated_col2} =
      File.stream!("./input_1.txt")
      |> Stream.map(&String.trim/1)
      |> Enum.reduce({column1, column2}, fn line, {acc_col1, acc_col2} ->
        [val1, val2] = String.split(line, "   ")
        {[val1 | acc_col1], [val2 | acc_col2]}
      end)

    # TODO: does this auto return?
    Enum.reduce(updated_col1, 0, fn val1, acc -> 
      count = Enum.count(updated_col2, fn val2 -> val2 == val1 end)
      acc + String.to_integer(val1) * count
    end)
  end

  def part1 do
    column1 = []
    column2 = []

    # why do we have updated_col1 and column1?
    {updated_col1, updated_col2} =
      File.stream!("./input_1.txt")
      |> Stream.map(&String.trim/1)
      |> Enum.reduce({column1, column2}, fn line, {acc_col1, acc_col2} ->
        [val1, val2] = String.split(line, "   ")
        {[val1 | acc_col1], [val2 | acc_col2]}
      end)

    if length(column1) != length(column2) do
      raise "Error: Column lengths are not equal!"
    end

    column1 = updated_col1 |> Enum.reverse() |> Enum.sort()
    column2 = updated_col2 |> Enum.reverse() |> Enum.sort()

    diff = Enum.zip(column1, column2)
    |> Enum.reduce(0, fn {val1, val2}, acc ->
      val1 = String.to_integer(val1)
      val2 = String.to_integer(val2)
      acc + abs(val1 - val2)
    end)

    IO.puts("Total difference: #{diff}")
  end
end
