require 'csv'

stitch = 'knit'
count = 0 
previous_cell = 1

CSV.foreach("bmt_pattern.csv") do |row|	
	columns = row.to_a
	columns.each do |cell|
		if cell != previous_cell
			puts "#{stitch} #{count}"
			if stitch == 'knit'
				stitch = 'purl'
			else
				stitch = 'knit' 
			end	
			count = 0
			previous_cell = cell
		end
		count += 1
	end
	puts "#{stitch} #{count}"
	stitch = 'knit'
	count = 0 
	previous_cell = 1
end
