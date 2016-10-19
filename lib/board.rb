# Add documentaion
class Board
  attr_reader :fields, :active, :passive, :checked
  # Initilaize new empty board object tith 8x8 empty fields
  def initialize
    @captured = []
    @ids = [1,2]
    @fields = []
    8.times.each do |row|
      @fields << []
      8.times.each do |col|
        @fields[row] << Field.new([row,col])
      end
    end
  end
  # display the current board
  def display
    nums = []
    8.downto(1).each {|n| nums.push n}
    print "\n"
    @fields.each_with_index do |row,i|
      if i == 0
        print "   " + black(" ")
        "a".upto("h").each { |l| print brown(black_f(l)) }
        print black(" ") + "\n"
      end
      row.each_with_index do |f,j|
        print "   " + brown(black_f(nums[i].to_s)) if j == 0
        s = f.figure.nil? ? " " : black_f(f.figure.sign)
        if i.modulo(2) == 0
          print white(s) if j.modulo(2) == 0
          print black(s) if j.modulo(2) == 1
        else
          print black(s) if j.modulo(2) == 0
          print white(s) if j.modulo(2) == 1
        end
        print brown(black_f(nums[i].to_s)) if j == 7
      end
      print "\n"
    end
    print "   " + black(" ")
    "a".upto("h").each { |l| print brown(black_f(l)) }
    print black(" ") + "\n\n"
  end
  # Check whether any king is checked
  def check
    @checked = []
    2.times do |p|
      p += 1
      enemy = (p == 1) ? 2 : 1
      figs = get_figs(p)
      king = get_figs(enemy,King)
      figs.each do |f|
        @checked << king[0].player_id if f.legal?(king[0].coords,self)
      end
      @checked.uniq!
      @checked.sort!
    end
  end
  # Check whether any king is mate
  def mate
    player_mate = nil
    self.check
    unless @checked.nil?
      @checked.each do |id|
        enemy = (id == 1) ? 2 : 1
        king = get_figs(id,King)
        figs = get_figs(enemy)
        moves = king[0].legal
        esc = Array.new(moves.length)
        figs.each do |f|
          moves.each_with_index { |m,i| esc[i] = true if f.legal?(m,self) }
        end
        player_mate = id if esc.all?
      end
    end
    return player_mate
  end
  # Move a figure from one coordinate to the other
  def move(from,to)
    from = to_coords(from)
    to = to_coords(to)
    fig = @fields[from[0]][from[1]].figure
    if fig.nil? or @active.nil?
      return false
    else
      return false unless fig.legal?(to,self) and fig.player_id == @active
      @fields[to[0]][to[1]].figure = fig
      fig.move(to,self)
      self.rm_figure(from)
      return self
    end
  end
  # Set the current player
  def set_player(id)
    @active = id
    @active == 1 ? @passive = 2 : @passive = 1
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
    @fields[coords[0]][coords[1]].figure = figure
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
  def brown(s)
    empt = "\e[43m#{" "}\e[0m"
    sign = empt+"\e[43m#{s}\e[0m"+empt
    s == " " ? empt*3 : sign
  end
  def black_f(s)
    "\e[30m#{s}\e[0m"
  end
  def black(s=" ")
    empt = "\e[41m#{" "}\e[0m"
    sign = empt+"\e[41m#{s}\e[0m"+empt
    s == " " ? empt*3 : sign
  end
  def white(s=" ")
    empt = "\e[47m#{" "}\e[0m"
    sign = empt+ "\e[47m#{s}\e[0m" +empt
    s == " " ? empt*3 : sign
  end
  def reverse(n)
    rev = []
    7.downto(0).each { |i| rev.push i }
    return rev[n]
  end
  def get_figs(id,figure=nil)
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
  def to_coords(str)
    str = str.downcase.strip.chars
    coords = []
    if str.length == 2
      str.each do |c|
        if (c =~ /\A\d+\z/ ? true : false)
          coords[0] = reverse(c.to_i-1)
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

