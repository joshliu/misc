require 'pry'
require 'open-uri'
require 'nokogiri'

base_url = 'http://www.convertunits.com/compounds/'
count = 0

url2 = 'http://www.csudh.edu/oliver/chemdata/atmass.htm'
doc2 = Nokogiri::HTML(open(url2))

out_file = File.new("compounds.yml", "w")

out_file.puts("---")
("A".."Z").each do |c|
  doc = Nokogiri::HTML(open(base_url+c+"/"))
  table = doc.css("table")[1]
  i = 0
  table.css("tr").each do |row|
  	if i != 0
	    out_file.puts "#{row.children[1].text.downcase}:"
	    out_file.puts "  name: #{row.children[1].text}"
	    out_file.puts "  formula: #{row.children[3].text}"
	    out_file.puts "  weight: #{row.children[5].text}"
	end
    i += 1
  end
  count += (i - 1)
end

table2 = doc2.css("table")[0]
j = 0
table2.css("tr").each do |row|
  if j != 0
    out_file.puts "#{row.children[1].text.downcase}:"
    out_file.puts "  name: #{row.children[1].text}"
    out_file.puts "  formula: #{row.children[3].text}"
    out_file.puts "  weight: #{row.children[7].text.gsub("(","").gsub(")","").to_f}"
  end
	j += 1
end

("A".."Z").each do |c|
  doc = Nokogiri::HTML(open(base_url+c+"/"))
  table = doc.css("table")[1]
  i = 0
  table.css("tr").each do |row|
  	if i != 0
	    out_file.puts "#{row.children[3].text.downcase}:"
	    out_file.puts "  name: #{row.children[1].text}"
	    out_file.puts "  formula: #{row.children[3].text}"
	    out_file.puts "  weight: #{row.children[5].text}"
	end
    i += 1
  end
  count += (i - 1)
end

j = 0
table2.css("tr").each do |row|
  if j != 0
    out_file.puts "#{row.children[1].text.downcase}:"
    out_file.puts "  name: #{row.children[1].text}"
    out_file.puts "  formula: #{row.children[3].text}"
    out_file.puts "  weight: #{row.children[7].text.gsub("(","").gsub(")","").to_f}"
  end
  j += 1
end
