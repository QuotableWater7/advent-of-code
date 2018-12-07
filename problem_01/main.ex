file_contents = File.read! __DIR__ <> "/input.txt"

numbers = String.split(file_contents)
	|> Enum.map(&String.to_integer/1)

# final_sum = Enum.reduce(numbers, 0, fn num, acc -> num + acc end)

defmodule Problem1
	def hello do
		IO.puts "hello"
	end
end

# frequency = Enum.reduce(
# 	numbers,
# 	%{ :current_sum => 0, :map_set => MapSet.new(), :first_repeated_frequency => nil },
# 	fn number, acc ->
# 		current_sum = acc[:current_sum] + number

# 		first_repeated_frequency = if acc[:first_repeated_frequency] do
# 			acc[:first_repeated_frequency]
# 		else
# 			acc[:map_set].member?(current_sum) ?
# 		end

# 		%{ :current_sum => current_sum, :map_set => Map.put(acc[:map_set], :current_sum, current_sum) }
# 	end
# )

# IO.puts Integer.to_string(final_sum)

# IO.puts frequency[:current_sum]
