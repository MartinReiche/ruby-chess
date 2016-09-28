# Add docu
class Figure
  attr_reader :name, :player, :player_id, :coords, :color
  
  
end

class Knight < Figure

  def initialize(player,coords)
    @name = "Knight"
    @player = player
    @player_id = @player.id
    @color = @player.color
    @coords = coords
  end
end
