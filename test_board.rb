require_relative './lib/chess'

board = Board.new

player = Player.new(1)
board.add_figure([4,3],'Knight',player)


# puts board.fields[0][5].inspect

board.print_fields
puts board.fields[4][3].figure.inspect
# puts knight.inspect
