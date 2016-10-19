require 'spec_helper'
require 'chess'

describe Board do
  it { is_expected.to respond_to(:fields) }
  it { is_expected.to respond_to(:active) }
  it { is_expected.to respond_to(:passive) }
  it { is_expected.to respond_to(:checked) }

  describe '.check' do
    before(:all) do
      @board = Board.new
      @player1 = Player.new(1)
      @player2 = Player.new(2)
      @board.add_figure('c6','king',@player1)
      @board.add_figure('a2','king',@player2)
    end
    it "returns empty if none of the Kings is checked" do
      @board.check
      expect(@board.checked).to be_empty
    end
    it "returns 1 if the King of Player 1 is checked" do
      @board.add_figure('c2','queen',@player2)
      @board.check
      expect(@board.checked).to eq([1])
    end
    it "returns 1 and 2 if both Kings are checked"  do
      @board.add_figure('b4','knight',@player1)
      @board.check
      expect(@board.checked).to eq([1,2])
    end
    it "returns 2 if the Kings of Player 2 is checked"  do
      @board.rm_figure([6,2])
      @board.check
      expect(@board.checked).to eq([2])
    end
  end
  describe '.mate' do
    before(:all) do
      @board = Board.new
      @player1 = Player.new(1)
      @player2 = Player.new(2)
      @board.add_figure('a8','king',@player1)
      @board.add_figure('h1','king',@player2)
    end
    it "is nil if none of the Kings is mate" do
      @board.add_figure('e4','queen',@player2)
      expect(@board.mate).to be nil
    end
    it "returns 1 if the Kings of Player 1 is mate" do
      @board.add_figure('a3','rook',@player2)
      @board.add_figure('f8','rook',@player2)
      expect(@board.mate).to eq(1)
    end
    it "returns 2 if the Kings of Player 2 is mate" do
      @board.rm_figure([0,5])
      @board.rm_figure([4,4])
      @board.rm_figure([7,0])
      @board.add_figure('h8','rook',@player1)
      @board.add_figure('a1','rook',@player1)
      @board.add_figure('f3','bishop',@player1)
      expect(@board.mate).to eq(2)
    end
  end

  describe '.set_player' do
    before(:all) do
      @board = Board.new
      @player1 = Player.new(1)
      @player2 = Player.new(2)
    end
    it "sets the current player" do
      expect(@board.active).to be nil
      expect(@board.passive).to be nil
      @board.set_player(@player1.id)
      expect(@board.active).to eq(1)
      expect(@board.passive).to eq(2)
      @board.set_player(@player2.id)
      expect(@board.active).to eq(2)
      expect(@board.passive).to eq(1)
    end
  end
  describe '.add_figure' do
    before(:all) do
      @board = Board.new
      @player = Player.new(1)
      @board.add_figure('a8','Knight',@player)
    end
    it "correctly initializes a knight" do
      expect(@board.fields[0][0].figure.class).to eq(Knight)
      expect(@board.fields[0][1].figure).to be nil
    end
  end
  describe '.rm_figure' do
    before(:all) do
      @board = Board.new
      @player = Player.new(1)
      @board.add_figure('c3','Knight',@player)
    end
    it "correctly removes a figure from the board" do
      expect(@board.fields[5][2].figure.class).to eq(Knight)
      @board.rm_figure([5,2])
      expect(@board.fields[5][2].figure).to be nil
    end
  end
  describe '.figures_a' do
    before(:all) { @board = Board.new }
    it "returns an array with the figure values" do
      expect(@board.fields).to be_a(Array)
      expect(@board.figures_a[7][7]).to be_nil
    end
  end
  describe '.move' do
    before(:all) do
      @board = Board.new
      @player1 = Player.new(1)
      @player2 = Player.new(2)
      @board.add_figure('b7','pawn',@player1)
    end
    it "returns false if origin field is empty" do
      expect(@board.move('c6','e3')).to be false
    end
    it "returns false if no current player is set" do
      expect(@board = @board.move('b7','b5')).to be false
    end
    it "returns false if current player doesn't owe figure" do
      @board.set_player(2)
      expect(@board = @board.move('b7','b5')).to be false
    end
    it "returns false for an illegal move" do
      @board.set_player(1)
      expect(@board.move('b7','e3')).to be false
    end
    it "returns the updated board for a legal move" do
      expect(@board.fields[1][1].figure).to be_a(Pawn)
      expect(@board.fields[3][1].figure).to be nil
      @board = @board.move('b7','b5')
      expect(@board.fields[1][1].figure).to be nil
      expect(@board.fields[3][1].figure).to be_a(Pawn)
    end
  end
end

describe Field do
  subject { Field.new([0,0]) }
  it { is_expected.to respond_to(:row) }
  it { is_expected.to respond_to(:col) }
  it { is_expected.to respond_to(:coord) }
  it { is_expected.to respond_to(:figure) }
  describe '.new' do
    before(:all) { @field = Field.new([2,1]) }
    it "should be initialized with coordinates" do
      expect(@field.coord).to eq([2,1])
    end
    it "row should be the first of coordinates" do
      expect(@field.row).to eq(@field.coord[0])
    end
    it "col should be the second of coordinates" do
      expect(@field.col).to eq(@field.coord[1])
    end
    it "should be initailized with as empty field" do
      expect(@field.figure).to be nil
    end
    it "raises an error when argument is not a an array" do
      expect {Field.new([1])}.to raise_error(ArgumentError)
      expect {Field.new([1,2,3])}.to raise_error(ArgumentError)
      expect {Field.new()}.to raise_error(ArgumentError)
    end
  end
end
