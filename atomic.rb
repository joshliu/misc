require 'pry'
require 'open-uri'
require 'active_record'
require 'nokogiri'

url = 'http://www.csudh.edu/oliver/chemdata/atmass.htm'

doc = Nokogiri::HTML(open(url))