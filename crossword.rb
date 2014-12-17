require 'pry'
require 'tesseract'

e = Tesseract::Engine.new {|e|
  e.language  = :eng
  e.blacklist = '|'
}

text = e.text_for('help.JPG').strip
text = text.gsub("0","O")
text = text.gsub("1","I")
lol = /[a-zA-Z]/.match(text)
array = []
sample = ""
$twod = []

text = text.split("")
text.each do |lol|
  if /[a-zA-Z\n]/.match(lol) != nil
    sample = sample + lol
  end
end

array = sample.split("\n")
array.pop
array << "ANTIBIOTIQUERENIKF"
array.each { |x| $twod << x.chars }

$twod[1].insert(8,"R")
$twod[1].insert(4,"R")
$twod[2].delete("f")

#SETUP COMPLETE LOL OCR SUCKS

def search(word)
  length = word.length
  (0...18-word.length).each do |x|
    (0...12).each do |y|
      test = ""
      (0...word.length).each do |z|
        test = test+$twod[y][x+z]
      end
      if test.downcase == word || test.downcase == word.reverse
        puts "word, #{x}, #{y}"
      end
    end
  end

  (0...18).each do |x|
    (0...12-word.length).each do |y|
      test = ""
      (0...word.length).each do |z|
        test = test+$twod[y+z][x]
      end
      if test.downcase == word || test.downcase == word.reverse
        puts "#{word}, #{x}, #{y}"
      end
    end
  end

  (0...18-word.length).each do |x|
    (0...12-word.length).each do |y|
      test = ""
      (0...word.length).each do |z|
        test = test+$twod[y+z][x+z]
      end
      if test.downcase == word || test.downcase == word.reverse
        puts "word, #{x}, #{y}"
      end
    end
  end

  (word.length...18).each do |x|
    (word.length...12).each do |y|
      test = ""
      (0...word.length).each do |z|
        test = test+$twod[y-z][x-z]
      end
      if test.downcase == word || test.downcase == word.reverse
        puts "word, #{x}, #{y}"
      end
    end
  end
end


binding.pry
