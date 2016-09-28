# Add documentaion
class Board
  attr_reader :fields
  def initialize
    @fields = []
    8.times.each do |row|
      8.times.each do |col|
        @fields << Field.new([row,col])
      end
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
