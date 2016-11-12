require_relative './lib/chess'

game = Game.new
game.set_path(File.expand_path(File.dirname(__FILE__)))
game.start
