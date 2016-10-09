# Add docu
class Figure
  attr_reader :name, :player, :player_id, :coords, :color, :type
  attr_reader :translate

  def get_attr(player,coords)
    @player = player
    @player_id = @player.id
    @color = @player.color
    @coords = coords
  end
end

class Knight < Figure
  def initialize(player,coords)
    self.get_attr(player,coords)
    @type = self.class
  end
  
end
