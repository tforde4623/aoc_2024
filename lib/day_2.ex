defmodule Day2 do

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

  defp is_safe(list) do
      ascending? = 
        Enum.chunk_every(list, 2, 1, :discard)
        |> Enum.all?(fn [a, b] -> a < b and abs(a - b) in 1..3 end)

      descending? = 
        Enum.chunk_every(list, 2, 1, :discard)
        |> Enum.all?(fn [a, b] -> a > b and abs(a - b) in 1..3 end)

      ascending? or descending?
  end
  
  def part1(file_path) do
    # should return how many reports are safe
    parse_reports_file(file_path)
    |> Enum.count(fn row -> is_safe(row) end) # enum vs stream?
  end

  defp process_with_removals(list, logic_fn) do
    list
    |> Enum.with_index()
    |> Enum.map(fn {_, idx} ->
      modified_list = List.delete_at(list, idx)
      logic_fn.(modified_list)
    end)
  end

  # does the same as is_safe/1 but allows for 1 fault (basically we allow 1 number that is outside of the 1..3 tolerance to be removed,
  # a note though, the numbers around it must follow the rules)
  defp is_safe_fault_tolerant(list) do
    process_with_removals(list, &is_safe/1)
    |> Enum.any?(&(&1))
  end

  def part2(file_path) do
    file_path
    |> parse_reports_file()
    |> Enum.map(&is_safe_fault_tolerant/1)
    |> Enum.count(&(&1))
  end

end
