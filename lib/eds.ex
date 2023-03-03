defmodule Eds do
  @moduledoc """
  Docs here...
  """
  @doc """
  If running a full benchmark is too much (or if you don't trust exactly what
  Benchee is doing), then you can run a manual benchmark here using this function.
  Just pass as arguments the standard module, functoin, and arguments.

  ## Examples

      iex> Eds.benchmark(Eds.VetFiles.Control, :run, ["tmp/files/index.txt"])
      iex> Eds.benchmark(Eds.VetFiles.Jsonrs, :run, ["tmp/files/index.txt"])
  """
  def benchmark(m, f, a) do
    start_time = :erlang.monotonic_time(:millisecond)
    apply(m, f, a)
    end_time = :erlang.monotonic_time(:millisecond)
    duration = end_time - start_time
    IO.puts("Duration: #{duration} ms")
  end
end
