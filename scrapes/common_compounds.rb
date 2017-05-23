require 'pry'
require 'open-uri'
require 'nokogiri'

base_url = 'http://www.convertunits.com/compounds/'
count = 0

out_file = File.new("compounds.yml", "w")

out_file.puts("---")
("A".."Z").each do |c|
  doc = Nokogiri::HTML(open(base_url+c+"/"))
  table = doc.css("table")[1]
  i = 0
  table.css("tr").each do |row|
    out_file.puts "- [\"#{row.children[1].text}\", \"#{row.children[3].text}\", \"#{row.children[5].text}\"]" if i != 0
    i += 1
  end
  count += (i - 1)
end
