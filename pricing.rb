#!/usr/bin/env ruby

prices=[0, 0, 20, 20, 20, 27.5, 30, 30, 40, 40, 40, 40, 45, 50, 60, 75]
cost=0


puts "optimal price: " + (Hash[prices.uniq.map do |price|
	[price, prices.select do |wtp|
		wtp >= price && price - cost > 0
	end.size*(price-cost)]
end].sort_by do |price, profit|
	profit
end.reverse.map do |price, profit|
	price
end.first.to_s) + "$"
