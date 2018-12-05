file_contents = File.read! __DIR__ <> "/input.txt"

result = String.split(file_contents)
	|> Enum.map(&String.to_integer/1)
	|> Enum.reduce(0, fn num, acc -> num + acc end)

IO.puts Integer.to_string(result)
