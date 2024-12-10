defmodule Mix.Tasks.Benchmark do
use Mix.Task

@shortdoc "Runs benchmarks for Day2 module"

def run(_) do
  Mix.Task.run("app.start")

  Benchee.run(%{
      "part2" => fn -> Day2.part2("./inputs/full/input_2.txt") end,
      })
  end
end
