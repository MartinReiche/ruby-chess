require_relative './chess'

class Game
  attr_reader :board, :players, :active
  # initialize new game object with a Board and 2 Player
  def initialize
    @board = Board.new
    @players = [Player.new(1), Player.new(2)]
    init_figures
    @drawn = false
    @msg = "Test message"
    @active = 0
  end
  def turn
    @msg = "Choose a figure."
    draw_board()
    choose()
    move()
  end
  private
  def switch_player
    @active == 0 ? @active = 1 : @active = 0
  end
  def draw_board(clear=15)
    clear_screen(clear) if @drawn
    print "\n   #{@msg}\n"
    @board.display
    # choose()
    @drawn = true
  end
  
  def move
    @board.set_player(@active+1)
    @board.move(@from,@to)
  end
  
  def choose
    status = ask_from
    status ? (is_own = @board.is_own_figure?(@from,@active)) : is_own = false
    until status and is_own
      @drawn = true
      @msg = "Invalid!"
      draw_board()
      status = ask_from
      status ? (is_own = @board.is_own_figure?(@from,@active)) : is_own = false
    end
    @msg = "Choose destination."
    draw_board()
    status = ask_to
    unless status 
      @msg = "Invalid move!"
      @drawn = true
      draw_board(15)
      status = ask_to
    end
  end
  def ask_from
    print "\n" + ("\e[A\e[K") + ("   #{@players[@active].name}, from >> ") 
    @from = gets.chomp
    return valid?(@from)
  end
  def ask_to
    print "\n" + ("\e[A\e[K") + ("   #{@players[@active].name}, #{@from} to >> ") 
    @to = gets.chomp
    return valid?(@to)
  end
  def valid?(str)
    str = str.downcase.strip.chars
    coords = []
    if str.length == 2
      str.each do |c|
        if (c =~ /\A\d+\z/ ? true : false)
          coords[0] = c.to_i-1
        else
          coords[1] = ("a".."z").find_index(c)
        end
      end
    end
    if coords.length == 2
      r = (0..7).include?(coords[0]) ? true : false
      c = (0..7).include?(coords[1]) ? true : false
    else
      return false
    end
    (r and c) ? true : false
  end
end

def reset_board
  init_figures
end
def clear_screen(lines)
  print "\r" + ("\e[A") * lines + "\e[J"
  @drawn = false
end
def init_figures
  fig_seq = ['rook','knight','bishop','queen','king','bishop','knight','rook']
  rows = [[1,2],[7,8]]
  @players.each_with_index do |p,i|
    rows[i].each do |n|
      "a".upto("h").each_with_index do |c,j|
        if [1,8].include?(n)
          @board.add_figure("#{c}#{n.to_s}","#{fig_seq[j]}",p)
        else
          # @board.add_figure("#{c}#{n.to_s}","pawn",p)
        end
      end
    end
  end
end


