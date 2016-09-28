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
      puts figs[row].inspect
    end
  end
end

# Field of chess board. Stores corrdinates and a reference to the current
# figure on the field.
class Field
  attr_reader :row, :col, :coord, :figure
  def initialize(coordinates)
    @@arg_err.call if (coordinates.class != Array) or (coordinates.length != 2) 
    @coord = coordinates
    @row = coord[0]
    @col = coord[1]
  end
  #Errors
  @@arg_err = Proc.new { raise ArgumentError.new("Argument must be an object of the Node class") }
end
