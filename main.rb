require_relative 'lib/game'

def start_game
  game = Game.new
  game.play
  restart_game
end

def restart_game
  print "\nDo you want to restart the game? Type 'y' to restart: "
  gets.chomp.downcase == 'y' ? start_game : puts('Thank you for playing!')
end

start_game