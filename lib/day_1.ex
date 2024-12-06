defmodule Day1 do

  # parsing for column specific file inputs
  defp parse_column_file(file_path) do
      File.stream!(file_path)
      |> Stream.map(&String.trim/1)
      |> Enum.reduce({[], []}, fn line, {acc_col1, acc_col2} ->
        [val1, val2] = String.split(line, "   ")
        {[val1 | acc_col1], [val2 | acc_col2]}
      end)
  end

  def part1(file_path) do
    {col1, col2} = parse_column_file(file_path)

    if length(col1) != length(col2) do
      raise "Error: Column lengths are not equal!"
    end

    col1
    |> Enum.reverse()
    |> Enum.sort()
    |> Enum.zip(Enum.reverse(col2) |> Enum.sort())
    |> Enum.reduce(0, fn {val1, val2}, acc -> 
      acc + abs(String.to_integer(val1) - String.to_integer(val2))
    end)
  end

  def part2(file_path) do
    {col1, col2} = parse_column_file(file_path)

    Enum.reduce(col1, 0, fn val1, acc -> 
      count = Enum.count(col2, fn val2 -> val2 == val1 end)
      acc + String.to_integer(val1) * count
    end)
  end

end
