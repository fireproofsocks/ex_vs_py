# To run:
#     mix run scripts/make_files.exs
#
# This script preps a directory with a bunch of files. There are
# a bunch of JSON files and a bunch of text files.
# The JSON files contain an array of "paths", which point to a text file
# that may or may not exist.
#
# After these files are created, an index file is created which contains
# on each line a relative path to one of the JSON files.
defmodule StringGenerator do
  @chars "abcdefghijklmnopqrstuvwxyz0123456790" |> String.split("", trim: true)

  def rand_str(length, separator \\ "") do
    Enum.reduce((1..length), [], fn (_i, acc) ->
      [Enum.random(@chars) | acc]
    end) |> Enum.join(separator)
  end
end

# Create a bunch of files
json_path = "tmp/files/jsons"
txt_path = "tmp/files/txts"
index_file = "tmp/files/index.txt"
index_stream = File.stream!(index_file)

File.mkdir_p(json_path)
File.mkdir_p(txt_path)

1..1_000
|> Stream.each(fn _ ->
  path = txt_path <> "/" <> StringGenerator.rand_str(3) <> ".txt"
  File.write!(path, "Content " <> StringGenerator.rand_str(20))
end)
|> Stream.run()

# Create a bunch of JSON files that contain references to txt files that
# may or may not exist
1..10_000
|> Stream.map(fn n ->
  dir = n |> Integer.to_string() |> String.split("") |> Enum.join("/")
  path = json_path <> dir
  File.mkdir_p(path)
  filename = path <> "#{n}.json"
  txt_files_cnt = :rand.uniform(10)

  txt_paths = 1..txt_files_cnt
  |> Enum.map(fn _ ->
    txt_path <> "/" <> StringGenerator.rand_str(3) <> ".txt"
  end)

  File.write!(filename, Jason.encode!(%{"paths" => txt_paths}))
  # prep the line for writing to the file
  filename <> "\n"
end)
|> Stream.into(index_stream)
|> Stream.run()
