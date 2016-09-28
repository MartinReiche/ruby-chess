require_relative './lib/chess'

board = Board.new

player = Player.new(1)

knight = Knight.new(player,[4,4])


puts knight.class
