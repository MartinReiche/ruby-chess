require_relative './lib/chess'

board = Board.new

player1 = Player.new(1)
player2 = Player.new(2)

board.add_figure('a1','rook',player1)
board.add_figure('H2','queen',player1)
board.add_figure('8g','knight',player2)
board.add_figure('b6','knight',player2)
board.add_figure('f6','king',player2)
board.add_figure('H8','pawn',player2)
board.add_figure('a8','pawn',player2)

# puts knight.inspect
board.display
