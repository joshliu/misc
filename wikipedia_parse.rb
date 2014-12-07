require 'pry'
require 'open-uri'
require 'nokogiri'

url_dictionary = {
	"http://en.wikipedia.org/wiki/List_of_museums_in_Ontario" => "ON",
	"http://en.wikipedia.org/wiki/List_of_museums_in_British_Columbia" => "BC",
	"http://en.wikipedia.org/wiki/List_of_museums_in_Alberta" => "AB",
	"http://en.wikipedia.org/wiki/List_of_museums_in_Manitoba" => "MB",
	"http://en.wikipedia.org/wiki/List_of_museums_in_New_Brunswick" => "NB",
	"http://en.wikipedia.org/wiki/List_of_museums_in_Newfoundland_and_Labrador" => "NL",
	"http://en.wikipedia.org/wiki/List_of_museums_in_Quebec" => "QC",
	"http://en.wikipedia.org/wiki/List_of_museums_in_Saskatchewan" => "SK"
}

def get_canadian_museums(url,museum_type,region)
	document = Nokogiri::HTML(open(url))
	table = document.css("table")[1]
	table.css("tr").each do |row|
		if row.children[7].text == museum_type
			puts "#{row.children[1].text} - #{row.children[3].text},#{region}"
		end
	end
end

def get_hongkong_museums(url,region)
	document = Nokogiri::HTML(open(url))
	table = document.css("table")[0]
	table.css("tr").each do |row|
		if row.children[1].text.include?("Art")
			puts "#{row.children[1].text} - #{row.children[3].text},#{region}"
		end
	end
end

def get_ontario_museums(url,museum_type,region)
	#ontario wiki page different format than other regions
	document = Nokogiri::HTML(open(url))
	table = document.css("table")[1]
	table.css("tr").each do |row|
		if row.children[9].text == museum_type
			puts "#{row.children[1].text} - #{row.children[3].text}, #{region}"
		end
	end
end

get_hongkong_museums("http://en.wikipedia.org/wiki/List_of_museums_in_Hong_Kong","HK")

# url_dictionary.each do |key, value|
# 	if value == "ON"
# 		get_ontario_museums(key,"Art",value)
# 	else
# 		get_canadian_museums(key,"Art",value)
# 	end
# end