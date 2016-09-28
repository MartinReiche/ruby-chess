require 'spec_helper'
require 'chess'

describe Figure do
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:player) }
  it { is_expected.to respond_to(:player_id) }
  it { is_expected.to respond_to(:coords) }
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
    it "is called 'Knight'" do
      expect(@knight.name).to eq("Knight")
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
  end
end
