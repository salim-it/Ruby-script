def stock_picker(array)
	buyDay = 0
	sellDay = 0 
	bestPrice = 0
	
	array.each_with_index{|value, index|
		 for i in index+1..(array.size-1)
			break if array[i] < value
			if bestPrice < (array[i] - value)
				bestPrice = array[i] - value
				sellDay = array.find_index(array[i])
				buyDay = index
			end		 
		 end
 
		}
    puts "for a profit of #{bestPrice}, buy for the #{buyDay}th day  and sell the #{sellDay}th day"
end


stock_picker([17,3,6,9,8,6,1,10]) 