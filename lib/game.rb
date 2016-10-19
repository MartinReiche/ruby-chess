require_relative './chess'

class Game
  attr_reader :board, :players
  def initialize
    @board = Board.new
    @players = [Player.new(1), Player.new(2)]
  end
end


