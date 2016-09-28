# Add docu
class Figure
  attr_reader :name, :player, :player_id, :coords, :color, :type

  def initialize(player,coords)
    @player = player
    @player_id = @player.id
    @color = @player.color
    @coords = coords
  end
end

class Knight < Figure
  
  
end
