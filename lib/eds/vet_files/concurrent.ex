defmodule Eds.VetFiles.Concurrent do
  @moduledoc """
  This uses `Task.async_stream/1` in an attempt to leveral multiple cores.
  """
  @behaviour Eds.VetFiles

  @impl true
  def run(index_file) do
    index_file
    |> File.stream!()
    |> Task.async_stream(
      fn line ->
        path = String.trim(line)
        {:ok, contents} = :prim_file.read_file(path)
        {:ok, %{"paths" => txt_paths}} = Jsonrs.decode(contents)
        txt_paths
      end,
      max_concurrency: 20,
      ordered: false
    )
    |> Stream.flat_map(fn {:ok, results} -> results end)
    # |> Stream.flat_map(fn results -> results end)
    |> Task.async_stream(
      fn file ->
        file = String.trim_trailing(file)
        match?({:ok, _}, :prim_file.read_file_info(file))
      end,
      max_concurrency: 10,
      ordered: false
    )
    |> Stream.run()
  end
end
