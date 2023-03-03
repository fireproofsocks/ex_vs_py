defmodule Eds.VetFiles.Control do
  @moduledoc """
  This is the first attempt at solving this problem in Elixir.
  It makes use of `File.read/1` and `File.exists?/2`
  """
  @behaviour Eds.VetFiles

  @impl true
  def run(index_file) do
    index_file
    |> File.stream!()
    |> Stream.each(fn line ->
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
