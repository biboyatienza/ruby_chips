require 'nokogiri'
require 'open-uri'

# Get a Nokogiri::HTML::Document for the page we’re interested in...

puts "Start scrapping : " + Time.now.to_s

pcso_link = 'http://www.pcso.gov.ph/lotto-search/?from_year=2000&from_month=01&from_day=01&category=all&to_year=2014&to_month=05&to_day=24&pagenum='
max_page_count = 1028
current_page = 1
# doc = Nokogiri::HTML(open('http://www.pcso.gov.ph/lotto-search/?from_year=2014&from_month=01&from_day=01&category=all&to_year=2014&to_month=05&to_day=23'))
while current_page <= max_page_count  do
	doc = Nokogiri::HTML(open(pcso_link + current_page.to_s))

	# Search for nodes by xpath
	doc.xpath('//table/tbody/tr').each do |tag|
		# puts tag.content.to_s.strip
		i = 1
		s = ''
		tag.search('td').each do |td|
			# puts i
			# puts td.content.to_s.strip
			# i = i + 1
			s = s +  (s.length > 0 ? '|' : '') + td.content.to_s.strip
		end	
		#puts s
		
		open('pcso.txt', 'a') do |f|
		  f.puts s
		end

	  # break
	end
	current_page += 1
end

puts "End of scrapping : " + Time.now.to_s


#open_pcso ("pcso.txt")

#def open_pcso(text_file)

	# File.open('pcso.txt', 'r') do |file|  
	#   while line = file.gets  
	#     puts line
	#     #puts line.split("|")
	#     line.split("|").each do |a|
	#     	puts a
	#     end	
	#     break
	#   end  
	# end

#end