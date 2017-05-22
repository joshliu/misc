require 'pry'
require 'open-uri'
require 'nokogiri'

url = 'http://www.csudh.edu/oliver/chemdata/atmass.htm'

doc = Nokogiri::HTML(open(url))

table = doc.css("table")[0]
table.css("tr").each do |row|
	puts "'#{row.children[3].text}' => #{row.children[7].text.gsub("(","").gsub(")","").to_f},"
end