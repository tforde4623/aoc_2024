defmodule Day1Test do
  use ExUnit.Case
  # what does doctest do?
  # doctest Aoc2024Elixir

  test "part1/1" do
    assert Day1.part1("./inputs/test/test_input_1.txt") == 11
  end

  test "part2/1" do
    assert Day1.part2("./inputs/test/test_input_1.txt") == 31
  end
end
