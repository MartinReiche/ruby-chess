require 'spec_helper'
require 'chess'

describe Figure do
  before(:each) { @player = Player.new(1) }
  subject { Figure.new() }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:player_id) }
  it { is_expected.to respond_to(:coords) }
  it { is_expected.to respond_to(:color) }
  it { is_expected.to respond_to(:sign) }
  it { is_expected.to respond_to(:moved) }

  describe '.move' do
    before(:all) do
      @player1 = Player.new(1)
      @board = Board.new
      @white = Pawn.new(@player1,[1,1])
    end
    it "moved is false before first move" do
      expect(@white.moved).to be false
    end
    it "changes moved to true after move" do
      @updated_board = @white.move([2,1],@board)
      expect(@white.moved).to be true
    end
    it "changes the coordinates of the figure" do
      expect(@white.coords).to eq([2,1])
    end
    it "returns false for an illegal move" do
      expect(@white.move([7,7],@board)).to be false
    end
  end
end

describe Pawn do
  it "inherits from Figure" do
    expect(Pawn).to be < Figure
  end
  describe '.new' do
    before(:all) do
      @player1 = Player.new(1)
      @player2 = Player.new(2)
      @board = Board.new
      @white = Pawn.new(@player1,[1,4])
      @black = Pawn.new(@player2,[6,2])
    end
    it "assigns the right color of the player" do
      expect(@white.color).to eq("white")
      expect(@black.color).to eq("black")
    end
    it "is marked as unmoved" do
      expect(@white.moved).to be false
    end
    it "has a white Pawn for Player 1" do
      expect(@white.sign).to eq("\u2659")
    end
    it "has a black Pawn for Player 2" do
      expect(@black.sign).to eq("\u265F")
    end
  end
  describe '.legal?' do
    before(:all) do
      @player1 = Player.new(1)
      @player2 = Player.new(2)
      @board = Board.new
      @board.add_figure('e6','knight',@player2)
      @board.add_figure('b3','knight',@player1)
      @board.add_figure('f6','knight',@player1)
      @white = Pawn.new(@player1,[1,4])
      @black = Pawn.new(@player2,[6,2])
    end
    it "returns true for a legal vertical move" do
      expect(@black.legal?([5,2],@board)).to be true
      expect(@black.legal?([4,2],@board)).to be true
    end
    it "returns true for a legal diagonal move" do
      expect(@black.legal?([5,1],@board)).to be true
    end
    it "returns false if field ahead is occupied by enemy" do
      expect(@white.legal?([2,4],@board)).to be false
    end
    it "returns false for an illegal move" do
      expect(@white.legal?([2,3],@board)).to be false
      expect(@white.legal?([2,5],@board)).to be false
      expect(@white.legal?([1,3],@board)).to be false
      expect(@white.legal?([1,5],@board)).to be false
      expect(@white.legal?([0,3],@board)).to be false
      expect(@white.legal?([0,4],@board)).to be false
      expect(@white.legal?([0,5],@board)).to be false
      expect(@black.legal?([5,3],@board)).to be false
      expect(@black.legal?([6,3],@board)).to be false
      expect(@black.legal?([7,3],@board)).to be false
      expect(@black.legal?([6,1],@board)).to be false
      expect(@black.legal?([7,1],@board)).to be false
      expect(@black.legal?([7,2],@board)).to be false
    end
    it "returns false if target is blocked by own figure" do
      expect(@white.legal?([2,5],@board)).to be false
    end
  end
  describe ".move" do
    before(:all) do
      @player1 = Player.new(1)
      @board = Board.new
      @white = Pawn.new(@player1,[1,2])
    end
    it "it can move forward 2 fields before initial move" do
      expect(@white.legal?([2,2],@board)).to be true
      expect(@white.legal?([3,2],@board)).to be true
    end
    it "it cannot move forward 2 fields after initial move" do
      @white.move([2,2],@board)
      expect(@white.legal?([3,2],@board)).to be true
      expect(@white.legal?([4,2],@board)).to be false
    end
  end
end

describe King do
  it "inherits from Figure" do
    expect(King).to be < Figure
  end
  describe '.new' do
    before(:all) do
      @board = Board.new
      @p1 = Player.new(1)
      @p2 = Player.new(2)
      @white = King.new(@p1,[3,4])
      @black = King.new(@p2,[3,6])
    end
    it "has a white King for Player 1" do
      expect(@white.sign).to eq("\u2654")
    end
    it "has a black King for Player 2" do
      expect(@black.sign).to eq("\u265A")
    end
  end
  describe '.legal?' do
    before(:all) do
      @player1 = Player.new(1)
      @player2 = Player.new(2)
      @board = Board.new
      @board.add_figure('e6','queen',@player1)
      @board.add_figure('d5','knight',@player2)
      @king = King.new(@player1,[3,4])
    end
    it "returns true for a legal diagonal move" do
      expect(@king.legal?([2,5],@board)).to be true
      expect(@king.legal?([2,3],@board)).to be true
      expect(@king.legal?([4,5],@board)).to be true
      expect(@king.legal?([4,3],@board)).to be true
    end
    it "returns true for a legal horizontal  move" do
      expect(@king.legal?([3,5],@board)).to be true
    end
    it "returns true for a legal vertical  move" do
      expect(@king.legal?([4,4],@board)).to be true
    end
    it "returns true if target is occupied by enemy figure" do
      expect(@king.legal?([3,3],@board)).to be true
    end
    it "returns false for an illegal move" do
      expect(@king.legal?([0,7],@board)).to be false
      expect(@king.legal?([1,1],@board)).to be false
      expect(@king.legal?([4,6],@board)).to be false
      expect(@king.legal?([5,6],@board)).to be false
    end
    it "returns false if target is blocked by own figure" do
      expect(@king.legal?([2,4],@board)).to be false
    end
  end
end

describe Bishop do
  it "inherits from Figure" do
    expect(Bishop).to be < Figure
  end
  describe '.new' do
    before(:all) do
      @board = Board.new
      @p1 = Player.new(1)
      @p2 = Player.new(2)
      @white = Bishop.new(@p1,[3,4])
      @black = Bishop.new(@p2,[3,6])
    end
    it "has a white Bishop for Player 1" do
      expect(@white.sign).to eq("\u2657")
    end
    it "has a black Bishop for Player 2" do
      expect(@black.sign).to eq("\u265D")
    end
  end

  describe '.legal?' do
    before(:all) do
      @player1 = Player.new(1)
      @player2 = Player.new(2)
      @board = Board.new
      @board.add_figure('f7','queen',@player1)
      @board.add_figure('a5','knight',@player2)
      @board.add_figure('d2','bishop',@player2)
      @bishop = Bishop.new(@player1,[4,1])
    end
    it "returns true for a legal diagonal move" do
      expect(@bishop.legal?([5,0],@board)).to be true
      expect(@bishop.legal?([2,3],@board)).to be true
    end
    it "returns true if target is occupied by enemy figure" do
      expect(@bishop.legal?([3,0],@board)).to be true
      expect(@bishop.legal?([6,3],@board)).to be true
    end
    it "returns false for an illegal move" do
      expect(@bishop.legal?([4,5],@board)).to be false
      expect(@bishop.legal?([6,1],@board)).to be false
      expect(@bishop.legal?([3,3],@board)).to be false
    end
    it "returns false if target is blocked by own figure" do
      expect(@bishop.legal?([1,5],@board)).to be false
    end
    it "returns false if path is blocked by own figure" do
      expect(@bishop.legal?([0,6],@board)).to be false
    end
    it "returns false if path is blocked by enemy figure" do
      expect(@bishop.legal?([7,4],@board)).to be false
    end
  end
end


describe Rook do
  it "inherits from Figure" do
    expect(Rook).to be < Figure
  end
  describe '.new' do
    before(:all) do
      @board = Board.new
      @p1 = Player.new(1)
      @p2 = Player.new(2)
      @white = Rook.new(@p1,[3,4])
      @black = Rook.new(@p2,[3,6])
    end
    it "has a white Rook for Player 1" do
      expect(@white.sign).to eq("\u2656")
    end
    it "has a black Rook for Player 2" do
      expect(@black.sign).to eq("\u265C")
    end
  end
  describe '.legal?' do
    before(:all) do
      @player1 = Player.new(1)
      @player2 = Player.new(2)
      @board = Board.new
      @board.add_figure('d6','queen',@player1)
      @board.add_figure('f1','knight',@player2)
      @rook = Rook.new(@player1,[7,3])
    end
    it "returns true for a legal horizontal move" do
      expect(@rook.legal?([7,1],@board)).to be true
    end
    it "returns true for a legal vertical move" do
      expect(@rook.legal?([5,3],@board)).to be true
      expect(@rook.legal?([4,3],@board)).to be true
    end
    it "returns true if target is occupied by enemy figure" do
      expect(@rook.legal?([7,5],@board)).to be true
    end
    it "returns false for an illegal move" do
      expect(@rook.legal?([4,5],@board)).to be false
      expect(@rook.legal?([8,8],@board)).to be false
    end
    it "returns false if target is blocked by own figure" do
      expect(@rook.legal?([2,3],@board)).to be false
    end
    it "returns false if path is blocked by own figure" do
      expect(@rook.legal?([0,3],@board)).to be false
    end
    it "returns false if path is blocked by enemy figure" do
      expect(@rook.legal?([7,7],@board)).to be false
    end
  end
end

describe Queen do
  it "inherits from Figure" do
    expect(Queen).to be < Figure
  end
  describe '.new' do
    before(:all) do
      @board = Board.new
      @p1 = Player.new(1)
      @p2 = Player.new(2)
      @white = Queen.new(@p1,[3,4])
      @black = Queen.new(@p2,[3,6])
    end
    it "has a white Queen for Player 1" do
      expect(@white.sign).to eq("\u2655")
    end
    it "has a black Queen for Player 2" do
      expect(@black.sign).to eq("\u265B")
    end
  end
  describe '.legal?' do
    before(:all) do
      @player1 = Player.new(1)
      @player2 = Player.new(2)
      @board = Board.new
      @board.add_figure('e7','queen',@player1)
      @board.add_figure('f5','knight',@player1)
      @board.add_figure('g4','knight',@player2)
      @queen = Queen.new(@player1,[4,4])
    end
    it "returns true for a legal horizontal move" do
      expect(@queen.legal?([4,1],@board)).to be true
    end
    it "returns true for a legal diagonal move" do
      expect(@queen.legal?([2,2],@board)).to be true
    end
    it "returns true for a legal vertical move" do
      expect(@queen.legal?([7,4],@board)).to be true
    end
    it "returns true if target is occupied by enemy figure" do
      expect(@queen.legal?([4,6],@board)).to be true
    end
    it "returns false for an illegal move" do
      expect(@queen.legal?([6,3],@board)).to be false
    end
    it "returns false if target is blocked by own figure" do
      expect(@queen.legal?([3,5],@board)).to be false
    end
    it "returns false if path is blocked by own figure" do
      expect(@queen.legal?([0,4],@board)).to be false
    end
    it "returns false if path is blocked by enemy figure" do
      expect(@queen.legal?([4,7],@board)).to be false
    end
  end
end

describe Knight do
  it "inherits from Figure" do
    expect(Knight).to be < Figure
  end
  describe '.new' do
    before(:all) do
      @p1 = Player.new(1)
      @p2 = Player.new(2)
      @white = Knight.new(@p1,[4,4])
      @black = Knight.new(@p2,[1,6])
    end
    it "has a white Knight for Player 1" do
      expect(@white.sign).to eq("\u2658")
    end
    it "has a black Knight for Player 2" do
      expect(@black.sign).to eq("\u265E")
    end
    it "has a player id" do
      expect(@white.player_id).to eq(@p1.id)
    end
    it "has coordinates" do
      expect(@white.coords).to eq([4,4])
    end
    it "has the color of the player" do
      expect(@white.color).to eq(@p1.color)
    end
  end
  describe '.legal?' do
    before(:all) do
      @player1 = Player.new(1)
      @player2 = Player.new(2)
      @board = Board.new
      @board.add_figure('c3','queen',@player1)
      @board.add_figure('d2','knight',@player2)
      @knight = Knight.new(@player1,[4,4])
    end
    it "returns true for legal move" do
      expect(@knight.legal?([6,5],@board)).to be true
    end
    it "returns false if target is occupied by own figure" do
      expect(@knight.legal?([5,2],@board)).to be false
    end
    it "returns true if target is occupied by enemy figure" do
      expect(@knight.legal?([6,3],@board)).to be true
    end
  end
end
