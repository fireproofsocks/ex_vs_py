defmodule Eds.VetFiles.PrimFile do
  @moduledoc """
  This variant relies on the Erlang `:prim_file`
  module instead of the Elixir `File` module.
  """
  @behaviour Eds.VetFiles

  @impl true
  def run(index_file) do
    index_file
    |> File.stream!()
    |> Stream.each(fn line ->
      path = String.trim(line)
      {:ok, contents} = :prim_file.read_file(path)
      {:ok, %{"paths" => txt_paths}} = Jason.decode(contents)

      Enum.each(txt_paths, fn p ->
        :prim_file.read_file_info(p)
      end)
    end)
    |> Stream.run()
  end
end
