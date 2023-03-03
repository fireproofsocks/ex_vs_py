defmodule Eds.VetFiles.Split do
  @moduledoc """
  This variant does NOT stream the file, but instead splits it
  """
  @behaviour Eds.VetFiles

  @impl true
  def run(index_file) do
    index_file
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.each(fn line ->
      path = String.trim(line)
      {:ok, contents} = File.read(path)
      {:ok, %{"paths" => txt_paths}} = Jason.decode(contents)

      Enum.each(txt_paths, fn p ->
        File.exists?(p, raw: true)
      end)
    end)
  end
end
