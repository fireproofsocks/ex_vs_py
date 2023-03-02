# This script will process an index file (created by `make_files.exs`)
# decode the JSON, and check whether the files it references exist or not.
start_time = DateTime.utc_now()
    |> DateTime.to_unix(:millisecond)

index_file = "tmp/files/index.txt"

index_file
|> File.stream!()
|> Task.async_stream(fn line ->
  path = String.trim(line)
  {:ok, contents} = :prim_file.read_file(path)
  {:ok, %{"paths" => txt_paths}} = Jason.decode(contents)

  Enum.each(txt_paths, fn p ->
    :prim_file.read_file_info(p)
  end)
end)
|> Stream.run()

end_time = DateTime.utc_now()
    |> DateTime.to_unix(:millisecond)

duration = end_time - start_time

IO.puts("Duration: #{duration} ms")
