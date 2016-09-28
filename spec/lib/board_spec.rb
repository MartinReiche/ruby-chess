require 'spec_helper'
require 'chess'

describe Board do
  it { is_expected.to respond_to(:fields) }
  
  describe '.coords_a' do
    before(:all) { @board = Board.new }
    it "returns an array with coordinate tuples" do
      expect(@board.fields).to be_a(Array)
      expect(@board.coords_a[1][0]).to eq([1,0])
    end
  end
  describe '.figures_a' do
    before(:all) { @board = Board.new }
    it "returns an array with the figure values" do
      expect(@board.fields).to be_a(Array)
      expect(@board.figures_a[7][7]).to be_nil
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
