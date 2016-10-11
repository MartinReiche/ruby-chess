# Parent class for chess figure
class Figure
  attr_reader :name, :player_id, :coords, :color
  # Assign fure unspecific attributes upon initilization 
  def get_attr(player,coords)
    @player_id = player.id
    @color = player.color
    @coords = coords
  end
  # check if the given position is a legal move 
  def legal?(to,board)
    @all_figs = board.figures_a
    legal.include?(to)
  end
end

# Class for figure of Queen
class Queen < Figure
  # Initialize a new Queen for given player at given coords 
  def initialize(player,coords)
    self.get_attr(player,coords)
  end
  private
  def legal
    pos = []
    translate = [[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1],[0,-1],[1,-1]]
    

    return pos
  end
end

# Class for figure of Knight 
class Knight < Figure
  # Initialize a new Knight for given player at given coords 
  def initialize(player,coords)
    self.get_attr(player,coords)
  end
  private
  def legal
    position = []
    translate = { 2 => [1,-1], -2 => [1,-1], 1 => [2, -2], -1 => [2,-2] }
    translate.keys.each do |first|
      if (0..7).include?(@coords[0] + first)
        translate[first].each do |sec|
          if (0..7).include?(@coords[1] + sec)
            next_pos = [@coords[0] + first, @coords[1] + sec]
            next_field = @all_figs[next_pos[0]][next_pos[1]]
            position << next_pos if next_field.nil? or next_field.player_id != @player_id
          end
        end
      end
    end
    return position
  end
end
