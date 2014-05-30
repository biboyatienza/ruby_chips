def create_find_game_string(game_description)
	# puts "g = Game.where(:description => \"#{game_description}\").first"
	append_to_seed_file("g = Game.where(:description => \"#{game_description}\").first")
end	

def create_new_result_string(draw_date, winning_combinations, jackpot_price, winners)
	# puts "r = Result.create(game_id: g.id, draw_date: \"#{draw_date}\", winning_combinations: \"#{winning_combinations}\", jackpot_price: #{jackpot_price}, winners: #{winners})"
	append_to_seed_file("r = Result.create(game_id: g.id, draw_date: \"#{draw_date}\", winning_combinations: \"#{winning_combinations}\", jackpot_price: #{jackpot_price}, winners: #{winners})")
end	

def create_new_combinations_string(winning_combinations)
	winning_combinations.split("-").each do |winning_number_value|
		# puts "Combination.create(result_id: r.id, winning_number: #{winning_number_value})"
		append_to_seed_file("Combination.create(result_id: r.id, winning_number: \"#{winning_number_value}\")")
	end	
end	

def append_to_file(file_name, content)
	open(file_name, 'a') do |f|
		  f.puts content
	end
end

def append_to_seed_file(content)
	append_to_file('seed.txt', content)
end


def column_value_fill_in(index, column_value)
	case index
	when 1
		$game_description_value = column_value
	when 2
		$winning_combinations_value = column_value
	when 3
		$draw_date_value = column_value
	when 4
		$jackpot_price_value = column_value.gsub(",", "")
	else
		$winners_value = column_value	
	end	
end 

puts "Creating seed... @ " + Time.now.to_s
File.open('pcso.txt', 'r') do |file|  
  while line = file.gets  
    index = 1

    line.split("|").each do |extracted_value|
    	column_value_fill_in(index, extracted_value)
    	index += 1
    end	

    create_find_game_string($game_description_value)
    create_new_result_string($draw_date_value, $winning_combinations_value, $jackpot_price_value, $winners_value)
    create_new_combinations_string($winning_combinations_value)
    # break
  end  
end
puts "End of Creating seed... @ " + Time.now.to_s

