def subString(string, dictionary)
	result = Hash.new(0)

	dictionary.each { |world|
			result[world] = string.scan(world).size if string.include?(world)
	}

	result
end

	
dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
world = "Howdy partner, sit down! How's it going?" 
puts subString(world, dictionary)
 

 