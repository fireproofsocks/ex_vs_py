defmodule Eds.VetFiles.AsyncStream do
  @moduledoc """
  This uses `Task.async_stream/1` in an attempt to leveral multiple cores.
  """
  @behaviour Eds.VetFiles

  @impl true
  def run(index_file) do
    index_file
    |> File.stream!()
    |> Task.async_stream(fn line ->
      path = String.trim(line)
      {:ok, contents} = File.read(path)
      {:ok, %{"paths" => txt_paths}} = Jason.decode(contents)

      Enum.each(txt_paths, fn p ->
        File.exists?(p)
      end)
    end)
    |> Stream.run()
  end
end
