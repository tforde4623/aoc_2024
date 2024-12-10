defmodule Day3 do

  # matches mul(x,y) statements to ["mul(x,y)", "x", "y"]
  @mul_regex ~r/mul\((\d{1,3}),\s*(\d{1,3})\)/
  # continues to match mul(x,y) statement like @mul_regex, also matches do() and don't()
  @cond_mul_regex ~r/(mul\((\d{1,3}),\s*(\d{1,3})\)|do\(\)|don't\(\))/

  def part1(file_path) do
    Regex.scan(@mul_regex, File.read!(file_path))
    |> Enum.reduce(0, fn [_, x, y], acc ->
      acc + String.to_integer(x) * String.to_integer(y)
    end)
  end

  def part2(file_path) do
    Regex.scan(@cond_mul_regex, File.read!(file_path))
    |> Enum.map(fn
          [_, "mul(" <> _ = match, x, y] -> [match, x, y] # mul(x, y)
          [_, match] -> match # do() or don't()
        end)
    |> Enum.reduce({0, :do}, fn op, {sum, prev_cond} ->
      case op do
        [_, x, y] -> if prev_cond == :do do
          {sum + String.to_integer(x) * String.to_integer(y), prev_cond}
        else
          {sum, prev_cond}
        end
        "do()" -> {sum, :do}
        "don't()" -> {sum, :dont}
      end
    end)
    |> elem(0)
  end

end
