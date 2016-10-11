require_relative './lib/chess'

board = Board.new

player = Player.new(1)
board.add_figure([4,4],'Queen',player)


a = board.fields[4][4].figure.legal?([3,3],board)
puts a.inspect
# puts knight.inspect
