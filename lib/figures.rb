# Add docu
class Figure
  attr_reader :name, :player, :player_id, :coords
  
  
end

class Knight < Figure

  def initialize(player,coords)
    @name = "Knight"
    @player = player
    @player_id = @player.id
    @coords = coords
  end
end
