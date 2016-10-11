require 'spec_helper'
require 'chess'

describe Figure do
  before(:each) { @player = Player.new(1) }
  subject { Figure.new() }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:player_id) }
  it { is_expected.to respond_to(:coords) }
  it { is_expected.to respond_to(:color) }
end

describe Rook do
  it "inherits from Figure" do
    expect(Rook).to be < Figure
  end
  describe '.legal?' do
    before(:all) do
      @player1 = Player.new(1)
      @player2 = Player.new(2)
      @board = Board.new
      @board.add_figure([2,3],'queen',@player1)
      @board.add_figure([7,5],'knight',@player2)
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
  describe '.legal?' do
    before(:all) do
      @player1 = Player.new(1)
      @player2 = Player.new(2)
      @board = Board.new
      @board.add_figure([1,4],'queen',@player1)
      @board.add_figure([3,5],'knight',@player1)
      @board.add_figure([4,6],'knight',@player2)
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
      @player = Player.new(1)
      @knight = Knight.new(@player,[4,4])
    end
    it "has a player id" do
      expect(@knight.player_id).to eq(@player.id)
    end
    it "has coordinates" do
      expect(@knight.coords).to eq([4,4])
    end
    it "has the color of the player" do
      expect(@knight.color).to eq(@player.color)
    end
  end
  describe '.legal?' do
    before(:all) do
      @player1 = Player.new(1)
      @player2 = Player.new(2)
      @board = Board.new
      @board.add_figure([5,2],'queen',@player1)
      @board.add_figure([6,3],'knight',@player2)
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
