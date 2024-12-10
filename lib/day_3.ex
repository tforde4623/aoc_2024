defmodule Day3 do

  @mul_regex ~r/mul\((\d{1,3}),\s*(\d{1,3})\)/

  def part1(file_path) do
    Regex.scan(@mul_regex, File.read!(file_path))
    |> Enum.reduce(0, fn [_, x, y], acc ->
      acc + String.to_integer(x) * String.to_integer(y)
    end)
  end

end
