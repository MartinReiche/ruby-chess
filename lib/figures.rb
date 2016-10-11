# Add docu
class Figure
  attr_reader :name, :player, :player_id, :coords, :color, :type
  attr_reader :translate, :legal

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
    @translate = { 2 => [1,-1], -2 => [1,-1], 1 => [2, -2], -1 => [2,-2] }
  end

  def steps_to(to,from=@coords)
    positions(from).each { |i| return i if i == to }

    
  end

  private

  def positions(from)
    pos = []
    @translate.keys.each do |first|
      if (0..7).include?(from[0] + first)
        @translate[first].each do |sec|
          if (0..7).include?(from[1] + sec)
            pos << [from[0] + first, from[1] + sec]
          end
        end
      end
    end
    pos.empty? ? (return nil) : (return pos)
  end
  
end
