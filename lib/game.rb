DICTIONARY = File.read("google-10000-english-no-swears.txt").split

class Game
  attr_accessor :secret_word, :guessed_letters

  def initialize
    @secret_word = select_random_word
    @letters = secret_word.split('')
    @guessed_letters = Array.new(secret_word.length, '_')
    @max_guesses = 7
    @guesses = 0
  end

  def select_random_word
    DICTIONARY.select { |word| word.length.between?(5, 12) }.sample
  end
end