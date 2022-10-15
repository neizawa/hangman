WORDS = File.read("google-10000-english-no-swears.txt").split

def select_random_word
  WORDS.select { |word| word.length.between?(5, 12) }.sample
end

puts select_random_word