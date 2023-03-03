defmodule Eds.VetFiles do
  @moduledoc """
  This use case tests a scenario derived from a real project where a large number
  of normalized JSON objects contained relative paths to related files. The task
  was to vet whether or not the related files existed or not.

  The input is a single "index" file where each line contains a path to a JSON file.

  To run these benchmarks:

      mix run scripts/make_files.exs
      mix run scripts/benchmark.exs
  """

  @callback run(index_file :: String.t()) :: any()
end
