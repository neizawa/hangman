DICTIONARY = File.read("google-10000-english-no-swears.txt").split

class Game
  attr_accessor :secret_word, :guessed_letters, :used_letters, :letters, :guess, :max_guess

  def initialize
    @secret_word = select_random_word
    @letters = secret_word.split('')
    @guessed_letters = Array.new(secret_word.length, '_')
    @used_letters = []
    @max_guess = secret_word.length + 5
    @guess = 0
  end

  def play
    until guess == max_guess || guessed_letters.none?('_')
      puts "\n#{guessed_letters.join(' ')}"
      puts "\nYou have #{max_guess - guess} guesses left."
      puts "Used letters: #{used_letters.join(', ').upcase}"
      print "Type a letter: "
      check_letters(input_letter)
      @guess += 1
    end

    if guessed_letters.any?('_')
      puts "\nYou are out of guesses. You lost."
    else
      puts "\nCongratulations! You won!"
    end

    puts "The secret word was '#{secret_word}'."
  end

  def select_random_word
    DICTIONARY.select { |word| word.length.between?(5, 12) }.sample
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
      print 'Wrong input. Try again: '
      input_letter
    end
  end

  def check_letters(input)
    letters.each_with_index do |letter, index|
      letter == input && guessed_letters[index] = letter
    end
  end
end