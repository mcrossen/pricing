#!/usr/bin/env ruby

# set the manufacturing cost
cost = if ARGV.include? "-c" then # check if it was passed in
	index = ARGV.index("-c") # if it was passed in, retrieve the argument index
	ARGV.delete_at(index) # delete the "-c" in the argument list, so it doesn't interfere later on
	ARGV.delete_at(index).to_i # set the cost to be the number right after "-c", delete the argument to prevent conflicts later
else # if no cost was passed in
	0 # the default cost of the product is zero
end

# read in the data
prices = if ARGV.include? "-f" then # check if a .csv spreadsheet was passed in
	# read in the spreadsheet, and split it into lines
	data = File.read(ARGV[ARGV.index("-f") + 1]).lines.map do |line|
		# remove trailing whitepace and commas for each line, then split it into individual cells
		line.chomp(' ').chomp(",").split(",").map do |cell|
			# remove leading or trailing whitespace from each cell
			cell.chomp(' ').reverse.chomp(' ').reverse
		end
	end
	# determine which column has the right data (the willingness to pay values)
	# this is done by checking the first row where the column titles hopefully are
	column_index = data.first.index("wtp") || data.first.index("willingness to pay")
	# everything after the first row is valid data
	data[1..-1].map do |line|
		# only keep the willingness-to-pay data
		line[column_index]
	end
else
	# if no spreadsheet was passed in, then use the values given on the command line
	ARGV
end.map do |wtp|
	wtp.to_i # convert all the data to integers
end

# this is where the actual calculation is done
# go through each unique proposed price until the highest profit is found
puts "optimal price: $" + (Hash[prices.uniq.map do |price|
	# create a mapping from each proposed price to that price's profit
	[price, prices.select do |wtp| # find how many of the sample would pay that price
		wtp >= price
	end.size*(price-cost)] # multiply the amount of people willing to pay by the profit margin
end].sort_by do |price, profit|
	profit # sort the propsed prices based on profit, then reverse for descending order
end.reverse.map do |price, profit|
	price # only keep the proposed prices
end.first.to_s) # the first element in the array is the price with the maximum profit
