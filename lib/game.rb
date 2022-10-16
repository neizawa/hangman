DICTIONARY = File.read('google-10000-english-no-swears.txt').split

class Game
  attr_accessor :secret_word, :guessed_letters, :used_letters, :max_guess, :guess

  def initialize(
    secret_word = select_random_word,
    used_letters = [],
    guessed_letters = Array.new(secret_word.length, '_')
  )
    @secret_word = secret_word
    @used_letters = used_letters
    @guessed_letters = guessed_letters

    @guess = 0
    @max_guess = secret_word.length
  end

  def play
    puts "\nIf you want to exit and save the game, type 'save'."

    until guess == max_guess || guessed_letters.none?('_')
      display_info
      check_letters(input_letter)

      @guess = (used_letters - guessed_letters).length
    end
    conclude
  end

  def display_info
    puts "\n#{guessed_letters.join(' ')}"
    puts "\nYou have #{max_guess - guess} incorrect guesses left."
    puts "Incorrect letters: #{(used_letters - guessed_letters).join(', ').upcase}"
    print 'Type a letter: '
  end

  def select_random_word
    DICTIONARY.select { |word| word.length.between?(5, 12) }.sample
  end

  def input_letter
    letter = gets.chomp.downcase

    if letter == 'save'
      save_game
    elsif used_letters.include?(letter)
      print 'Already used. Try another letter: '
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
    secret_word.split('').each_with_index do |letter, index|
      letter == input && guessed_letters[index] = letter
    end
  end

  def conclude
    if guessed_letters.any?('_')
      puts "\nYou are out of guesses. You lost."
    else
      puts "\nCongratulations! You won!"
    end

    puts "The secret word was '#{secret_word}'."
  end

  def save_game
    file_count = Dir.glob('saves/*.json').length
    filename = "#{(file_count + 1).to_s.rjust(3, '0')}.json"

    File.open("saves/#{filename}", 'w') do |file|
      JSON.dump({
                  secret_word: @secret_word,
                  used_letters: @used_letters,
                  guessed_letters: @guessed_letters
                }, file)
    end

    puts "Game saved in '#{filename}'. Thank you for playing!"
    exit
  end

  def self.load_game(filename)
    data = JSON.parse(File.read(filename))
    Game.new(
      data['secret_word'],
      data['used_letters'],
      data['guessed_letters'],
    ).play
  end
end
