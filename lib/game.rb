require_relative 'display.rb'

DICTIONARY = File.read("google-10000-english-no-swears.txt").split

class Game
  include Display
  attr_accessor :secret_word, :guessed_letters, :used_letters

  def initialize
    @secret_word = select_random_word
    @letters = secret_word.split('')
    @guessed_letters = Array.new(secret_word.length, '_')
    @used_letters = ['a']
    @max_turn = 7
    @turn = 0
  end

  def play
    display_letters
    print "\nType a letter: "
    input_letter
  end

  def input_letter
    letter = gets.chomp.downcase

    if used_letters.include?(letter)
      print 'Chosen letter is already used. Try another letter: '
      input_letter
    elsif letter.match?(/^[a-z]{1}$/)
      used_letters << letter
      letter
    else
      print 'Not a letter. Try again: '
      input_letter
    end
  end

  def select_random_word
    DICTIONARY.select { |word| word.length.between?(5, 12) }.sample
  end
end