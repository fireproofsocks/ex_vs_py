# Before benchmarking these, make sure you run
# mix run scripts make_files.exs
# That's what generates the files which these modules read.
Benchee.run(
  %{
    "File" => fn -> Eds.VetFiles.Control.run("tmp/files/index.txt") end,
    "Task.async_stream" => fn -> Eds.VetFiles.AsyncStream.run("tmp/files/index.txt") end,
    ":prim_file" => fn -> Eds.VetFiles.PrimFile.run("tmp/files/index.txt") end,
    ":prim_file async" => fn -> Eds.VetFiles.PrimFileAsync.run("tmp/files/index.txt") end,
    "Jsonrs" => fn -> Eds.VetFiles.Jsonrs.run("tmp/files/index.txt") end,
    "Split file" => fn -> Eds.VetFiles.Split.run("tmp/files/index.txt") end,
    "Concurrent" => fn -> Eds.VetFiles.Concurrent.run("tmp/files/index.txt") end,
    "python" => fn -> Eds.VetFiles.Python.run("tmp/files/index.txt") end
  },
  time: 10,
  warmup: 0
)
