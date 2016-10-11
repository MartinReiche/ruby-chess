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
  # Check legal moves for Queen, Bishop and Rook and king
  def qbr_legal(translate,king=false)
    pos = []
    @translate.each do |t|
      valid = true
      move = @coords
      while valid
        valid = false if king
        move = move.zip(t).map { |i,j| i+j }
        if (0..7).include?(move[0]) and (0..7).include?(move[1])
          next_field = @all_figs[move[0]][move[1]]
          if !next_field.nil? 
            pos << move if next_field.player_id != @player_id
            valid = false
          else
            pos << move
          end
        else
          valid = false
        end
      end
    end
    return pos
  end
end

# Class for figure of Queen
class Queen < Figure
  # Initialize a new Queen for given player at given coords 
  def initialize(player,coords)
    self.get_attr(player,coords)
    @translate = [[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1],[0,-1],[1,-1]]
  end
  private
  def legal
    qbr_legal(@translate)
  end
end

# Class for figure of King
class King < Queen
  private
  def legal
    qbr_legal(@translate,true)
  end
end

# Class for figure of Bishop
class Bishop < Figure
  # Initialize a new Bishop for given player at given coords 
  def initialize(player,coords)
    self.get_attr(player,coords)
    @translate = [[1,1],[-1,1],[-1,-1],[1,-1]]
  end
  private
  def legal
    qbr_legal(@translate)
  end
end

# Class for figure of Rook
class Rook < Figure
  # Initialize a new Rook for given player at given coords 
  def initialize(player,coords)
    self.get_attr(player,coords)
    @translate = [[1,0],[-1,0],[0,1],[0,-1]]
  end
  private
  def legal
    qbr_legal(@translate)
  end
end

# Class for figure of Knight 
class Knight < Figure
  # Initialize a new Knight for given player at given coords 
  def initialize(player,coords)
    self.get_attr(player,coords)
    @translate = { 2 => [1,-1], -2 => [1,-1], 1 => [2, -2], -1 => [2,-2] }
  end
  private
  def legal
    position = []
    @translate.keys.each do |first|
      if (0..7).include?(@coords[0] + first)
        @translate[first].each do |sec|
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
