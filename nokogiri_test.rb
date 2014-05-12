require 'open-uri'
require 'nokogiri'
require 'pry'
require 'active_record'

url = "http://www.chem.qmul.ac.uk/iupac/AtWt/"
url2 = "http://en.wikipedia.org/wiki/Atomic_radii_of_the_elements_(data_page)"

doc = Nokogiri::HTML(open(url))
doc2 = Nokogiri::HTML(open(url2))

class Element < ActiveRecord::Base
	establish_connection(adapter:'mysql2',
		database:'elements'
	)
end

table = doc.css("table")[1]
table.css("tr").each do |row|
	if row.children[1].text.length > 3
		next
	end
	puts row.children[2].text
	e = Element.new
	e.atomic_num = row.children[0].text.to_i
	e.symbol = row.children[1].text
	e.name = row.children[2].text
	e.mass = row.children[3].text.gsub("[","").gsub("]","").to_f
	e.save
end

table2 = doc2.css("table")[0]
table2.css("tr").each do |row|


binding.pry