require 'pry'
require 'open-uri'
require 'nokogiri'

url = 'http://www.csudh.edu/oliver/chemdata/atmass.htm'

doc = Nokogiri::HTML(open(url))

out_file = File.new("elements.yml", "w")

out_file.puts("---")
table = doc.css("table")[0]

i = 0
table.css("tr").each do |row|
	out_file.puts "[\"#{row.children[3].text}\", \"#{row.children[7].text.gsub("(","").gsub(")","").to_f}\"]" if i != 0
  i += 1
end