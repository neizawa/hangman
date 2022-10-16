require 'json'
require_relative 'lib/game'

def play_game
  print "Do you want to continue last game? Type 'y' to continue: "

  if gets.chomp.downcase == 'y'
    print "\nType the name of the save file from 'saves' folder: "
    load_game
  else
    start_game
  end
end

def start_game
  Game.new.play
  restart_game
end

def load_game
  filename = "saves/#{gets.chomp}.sv"

  if File.file?(filename)
    Game.load_game(filename)
  else
    print 'No such file. Try again: '
    load_game
  end

  restart_game
end

def restart_game
  print "\nDo you want to restart the game? Type 'y' to restart: "
  gets.chomp.downcase == 'y' ? start_game : puts('Thank you for playing!')
end

play_game
