# coding: utf-8
require_relative './chess'

class Game
  attr_reader :board, :players, :active, :checked, :mate, :quit, :path
  # initialize new game object with a Board and 2 Player
  def initialize
    @board = Board.new
    @players = [Player.new(1), Player.new(2)]
    @drawn = false
    @active = 0
    @quit = false
  end
  def start
    init_figures()
    run()
  end
  def set_path(str)
    @path = str
  end
  private
  def save
    s = Chess::Savegame.new
    s.b = @board
    s.p = @players
    s.a = @active
    s.c = @checked
    s.m = @mate
    s.save(@path)
  end
  def load
    s = Chess::Savegame.new
    s.load(@path)
    
  end
  def opt(str)
    if ["menu","m","h","help","o","options","s","save"].include?(str.downcase)
      clear_screen(15)
      print "\n\n   Options\n\n\n"
      print "   n - start new game\n"
      print "   l - load game\n"
      print "   s - save game\n"
      print "   q - quit game\n\n\n\n\n\n"
      print "\n" + ("\e[A\e[K") + ("   choose option >> ")
      option = gets.chomp
      case option.downcase
      when "n"
        initialize()
        @drawn = true
        start()
      when "l"
        load()
      when "s"
        save()
      when "q"
        clear_screen(15)
        abort
      end
      return true
    end
    return false
  end
  def run
    while @mate.nil? 
      @checked = @board.check
      turn
      @mate = @board.mate(@checked)
      after = @board.check
      if after[0] == @board.active
        @mate = @board.active
      end
    end
    if !@mate.nil?
      won = @mate == 1 ? 2:1
      puts "Game over! Player #{won} has won!"
    end
  end
  def turn
    if @checked.empty?
      @msg = "Choose a figure. (m: menu)"
    else
      @msg = "Choose a figure. Player #{@checked[0]} is checked!" if @checked.length == 1
      @msg = "Choose a figure. Both players are checked!" if @checked.length == 2
    end
    status = false
    until status 
      draw_board()
      choose()
      status = move()
      if status == true
        switch_player()
      end
    end
  end
  def switch_player
    @active == 0 ? @active = 1 : @active = 0
  end
  def draw_board(clear=15)
    clear_screen(clear) if @drawn
    print "\n   #{@msg}\n"
    @board.display
    @drawn = true
  end
  def move
    @board.set_player(@active+1)
    status = @board.move(@from,@to)
    if status == false
      @msg = "Invalid move"
      draw_board()
      puts "\n"
      sleep(1)
      return false
    end
    return true
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
    status = opt(@from)
    if status
      clear_screen(15)
      draw_board
      ask_from
    else
      return valid?(@from)
    end
  end
  def ask_to
    print "\n" + ("\e[A\e[K") + ("   #{@players[@active].name}, #{@from} to >> ") 
    @to = gets.chomp
    status = opt(@to)
    if status
      clear_screen(15)
      draw_board
      ask_to
    else
      return valid?(@to)
    end
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
          @board.add_figure("#{c}#{n.to_s}","pawn",p)
        end
      end
    end
  end
end


