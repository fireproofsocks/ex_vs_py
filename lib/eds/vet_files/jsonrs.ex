defmodule Eds.VetFiles.Jsonrs do
  @moduledoc """
  This variant relies on Jsonrs for JSON decoding
  """
  @behaviour Eds.VetFiles

  @impl true
  def run(index_file) do
    index_file
    |> File.stream!()
    |> Stream.each(fn line ->
      path = String.trim(line)
      {:ok, contents} = File.read(path)
      {:ok, %{"paths" => txt_paths}} = Jsonrs.decode(contents)

      Enum.each(txt_paths, fn p ->
        File.exists?(p)
      end)
    end)
    |> Stream.run()
  end
end
