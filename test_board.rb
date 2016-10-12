require_relative './lib/chess'

board = Board.new

player1 = Player.new(1)
player2 = Player.new(2)

board.add_figure([7,3],'rook',player1)
board.add_figure([2,3],'queen',player1)
board.add_figure([7,5],'knight',player2)
board.add_figure([6,2],'knight',player2)


a = board.fields[6][2].figure.legal?([7,5],board)
puts a.inspect
# puts knight.inspect
