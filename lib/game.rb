DICTIONARY = File.read("google-10000-english-no-swears.txt").split

class Game
  def initialize
    @secret_word = select_random_word
    @max_guesses = 7
    @guesses = 0
  end

  def select_random_word
    DICTIONARY.select { |word| word.length.between?(5, 12) }.sample
  end
end