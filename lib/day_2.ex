
defmodule Problem2 do

  # TODO: can we make a parse_file function, where we can pass in the logic
  # as a callback function?
  # parse the report file into a 2d array of integers
  # TODO: add the integer parsing in the first problem too
  # TODO: it might not be worth it, but can we combine the logic of
  # the parsing and the logic in this and the first problem? Maybe using a
  # callback function or something?
  defp parse_reports_file(file_path) do
    File.stream!(file_path)
    |> Stream.map(&String.trim/1)
    |> Enum.map(fn line -> 
      line
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
    end)
  end

# TODO: def vs defp
  def is_safe?([]), do: true
  def is_safe?([_]), do: true
  def is_safe?([a, b | rest]) do
    abs(a - b) in 1..3 and is_safe?([b | rest])
  end
  
  def part1 do
    # should return how many reports are safe
    report = parse_reports_file("./inputs/test_input_2.txt")

    # enum vs stream map
    report
    |> Enum.map(&is_safe?/1)
  end

  def part2 do
    
  end

end
