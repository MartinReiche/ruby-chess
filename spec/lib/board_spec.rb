require 'spec_helper'
require 'chess'

describe Board do
  it { is_expected.to respond_to(:fields) }
  it { is_expected.to respond_to(:active) }
  it { is_expected.to respond_to(:passive) }

  describe '.check' do
    before(:all) do
      @board = Board.new
      @player1 = Player.new(1)
      @player2 = Player.new(2)
      @board.add_figure('c3','king',@player1)
      @board.add_figure('a7','king',@player2)
    end
    it "returns false if none of the Kings is checked" do
      expect(@board.check).to be false
    end
    it "returns 1 if the Kings of Player 1 is checked" do
      @board.add_figure('c7','queen',@player2)
      expect(@board.check).to eq(1)
    end
    it "returns 2 if the Kings of Player 2 is checked"  do
      @board.add_figure('b5','knight',@player1)
      expect(@board.check).to eq(2)
    end
  end

  describe '.mate' do
    it "returns false if none of the Kings is mate"
    it "returns 1 if the Kings of Player 1 is mate"
    it "returns 2 if the Kings of Player 2 is mate" 
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
      @board.add_figure('a1','Knight',@player)
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
      @board.add_figure('c6','Knight',@player)
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
      @board.add_figure('b2','pawn',@player1)
    end
    it "returns false if origin field is empty" do
      expect(@board.move('c3','e6')).to be false
    end
    it "returns false if no current player is set" do
      expect(@board = @board.move('b2','b4')).to be false
    end
    it "returns false if current player doesn't owe figure" do
      @board.set_player(2)
      expect(@board = @board.move('b2','b4')).to be false
    end
    it "returns false for an illegal move" do
      @board.set_player(1)
      expect(@board.move('b2','e6')).to be false
    end
    it "returns the updated board for a legal move" do
      expect(@board.fields[1][1].figure).to be_a(Pawn)
      expect(@board.fields[3][1].figure).to be nil
      @board = @board.move('b2','b4')
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
