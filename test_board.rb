require_relative './lib/chess'

board = Board.new

player = Player.new(1)
board.add_figure([1,2],'Knight',player)


a = board.fields[1][2].figure.steps_to([3,3])
puts a.inspect
# puts knight.inspect
