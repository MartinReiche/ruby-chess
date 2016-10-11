require 'spec_helper'
require 'chess'

describe Figure do
  before(:each) { @player = Player.new(1) }
  subject { Figure.new() }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:player) }
  it { is_expected.to respond_to(:player_id) }
  it { is_expected.to respond_to(:coords) }
  it { is_expected.to respond_to(:color) }
  it { is_expected.to respond_to(:translate) }
end

describe Knight do
  it "should inherit from Figure" do
    expect(Knight).to be < Figure
  end
  describe '.new' do
    before(:all) do
      @player = Player.new(1)
      @knight = Knight.new(@player,[4,4])
    end
    it "has a type of Knight" do
      expect(@knight).to be_a(Knight)
    end
    it "is assigned to a player" do
      expect(@knight.player).to eq(@player)
    end
    it "has a player id" do
      expect(@knight.player_id).to eq(@player.id)
    end
    it "has coordinates" do
      expect(@knight.coords).to eq([4,4])
    end
    it "should have the color of the player" do
      expect(@knight.color).to eq(@player.color)
    end
  end
  describe '.steps_to' do
    before(:all) do
      @player = Player.new(1)
      @knight = Knight.new(@player,[4,4])
    end
    context "when valid coordinates are given" do
      it "shows a single valid step" do
        expect(@knight.steps_to([6,5])).to eq([6,5])
      end
      it "shows a cascade of steps to given cordinates" do
        expect(@knight.steps_to([6,9])).to eq([[5,6],[7,7],[6,9]])
      end
    end
    context "when invalid coordinates are given" do
      it "returns nil when of the board"
      it "returns nil when occupied by own figure"
    end
  end
end
