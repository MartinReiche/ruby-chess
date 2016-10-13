# Add documentaion
class Board
  attr_reader :fields, :active, :passive, :player
  # Initilaize new empty board object tith 8x8 empty fields
  def initialize
    @ids = [1,2]
    @fields = []
    8.times.each do |row|
      @fields << []
      8.times.each do |col|
        @fields[row] << Field.new([row,col])
      end
    end
  end
  # Check whether any king is checked
  def check
    2.times do |player|
      figs = get_figs(player)
      # enemy_king = get_king(
    end
  end
  # Move a figure from one coordinate to the other
  def move(from,to)
    from = to_coords(from)
    to = to_coords(to)
    fig = @fields[from[0]][from[1]].figure
    if fig.nil? or @player.nil?
      return false
    else
      return false unless fig.legal?(to,self) and fig.player_id == player.id
      @fields[to[0]][to[1]].figure = fig
      fig.move(to,self)
      self.rm_figure(from)
      return self
    end
  end
  # Set the current player
  def set_player(id)
    @player = player
  end
  # Add a figure of 'type' to coordinates of 'coords'
  def add_figure(str,type,player)
    coords = to_coords(str)
    case type.downcase
    when 'knight' then figure = Knight.new(player,coords)
    when 'queen' then figure = Queen.new(player,coords)
    when 'rook' then figure = Rook.new(player,coords)
    when 'bishop' then figure = Bishop.new(player,coords)
    when 'king' then figure = King.new(player,coords)
    when 'pawn' then figure = Pawn.new(player,coords)
    else
      return 'Wrong figure type'
    end
    self.fields[coords[0]][coords[1]].figure = figure
  end
  # Remove figure on given 'coords' 
  def rm_figure(coords)
    self.fields[coords[0]][coords[1]].figure = nil
  end
  # Return an array with the cuurent figures of the fields
  def figures_a
    figs = []
    8.times do |row|
      figs << []
      8.times do |col|
        figs[row] << self.fields[row][col].figure
      end
    end
    return figs
  end

  private
  def get_figs(id)
    figs = figures_a
    player_figs = []
    figs.each do |row|
      row.each do |f|
        unless f.nil?
          if figure.nil?
            player_figs << f if f.player_id == id
          else
            player_figs << f if f.player_id == id and f.class == figure
          end
        end
      end
    end
    return player_figs
  end
  def get_king(id)
    figs = get_figs(id)
    figs.each 
  end
  def to_coords(str)
    str = str.downcase.strip.chars
    coords = []
    if str.length == 2
      str.each do |c|
        if (c =~ /\A\d+\z/ ? true : false)
          coords[0] = (c.to_i-1)
        else
          coords[1] = ("a".."z").find_index(c) 
        end
      end
      return coords
    end
  end
end

# Field of chess board. Stores corrdinates and a reference to the current
# figure on the field.
class Field
  attr_reader :row, :col, :coord
  attr_accessor :figure
  def initialize(coordinates)
    @@arg_err.call if (coordinates.class != Array) or (coordinates.length != 2) 
    @coord = coordinates
    @row = coord[0]
    @col = coord[1]
  end
  #Errors
  @@arg_err = Proc.new { raise ArgumentError.new("Argument must be an object of the Node class") }
end
