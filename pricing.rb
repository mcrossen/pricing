#!/usr/bin/env ruby

cost = if ARGV.include? "-c" then
	index = ARGV.index("-c")
	ARGV.delete_at(index)
	ARGV.delete_at(index).to_i
else
	0 # the default cost of the product is zero
end

prices = if ARGV.include? "-f" then
	data = File.read(ARGV[ARGV.index("-f") + 1]).lines.map do |line|
		line.chomp(' ').chomp(",").split(",").map do |cell|
			cell.chomp(' ').reverse.chomp(' ').reverse
		end
	end
	column_index = data.first.index("wtp") || data.first.index("willingness to pay")
	data[1..-1].map do |line|
		line[column_index]
	end
else
	ARGV
end.map do |wtp|
	wtp.to_i
end

puts "optimal price: $" + (Hash[prices.uniq.map do |price|
	[price, prices.select do |wtp|
		wtp >= price
	end.size*(price-cost)]
end].sort_by do |price, profit|
	profit
end.reverse.map do |price, profit|
	price
end.first.to_s)
