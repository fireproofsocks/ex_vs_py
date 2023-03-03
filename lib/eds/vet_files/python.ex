defmodule Eds.VetFiles.Python do
  @moduledoc """
  This shells out to a Python script
  """
  @behaviour Eds.VetFiles

  @impl true
  def run(index_file) do
    System.cmd("python", ["scripts/vet_files.py", index_file])
  end
end
