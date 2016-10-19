require_relative './lib/chess'

board = Board.new

player1 = Player.new(1)
player2 = Player.new(2)

board.add_figure('a8','pawn',player2)

# puts knight.inspect
board.display
