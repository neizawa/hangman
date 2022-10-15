require_relative 'lib/game'

def start_game
  game = Game.new
  game.play
end

start_game