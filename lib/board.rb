# Add documentaion
class Board
  attr_reader :fields
  # Initilaize new empty board object tith 8x8 empty fields
  def initialize
    @fields = []
    8.times.each do |row|
      @fields << []
      8.times.each do |col|
        @fields[row] << Field.new([row,col])
      end
    end
  end
  # Move a figure from one coordinate to the other
  def move(from,to)
    fig = @fields[from[0]][from[1]].figure
    if fig.nil?
      return false
    else
      return false unless fig.move(to,self)
      @fields[to[0]][to[1]].figure = fig
      self.rm_figure(from)
      return self
    end
  end
  # Add a figure of 'type' to coordinates of 'coords'
  def add_figure(coords,type,player)
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
  # Return an array with tuples of coordinates for the fields
  def coords_a
    coords = []
    8.times do |row|
      coords << []
      8.times { |col| coords[row] << [row, col] }
    end
    return coords
  end
  # Print coordinates 
  def print_coords
    coords = self.coords_a
    8.times do |row|
      puts coords[row].inspect
    end
  end
  # Return an array with the cuurent figures of the fields
  def figures_a
    figs = []
    8.times do |row|
      figs << []
      8.times { |col| figs[row] << self.fields[row][col].figure }
    end
    return figs
  end
  # Print figures on the board
  def print_fields
    figs = self.figures_a
    8.times do |row|
      8.times do |col|
        figs[row][col].nil? ? (print "  nil  ") : (print " #{figs[row][col].type} ")
      end
      print "\n"
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
