require 'spec_helper'
require 'chess'

describe Player do
  subject { Player.new(1) }
  before(:all) { @player = Player.new(1,'Foo') }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:color) }

  it "has a name" do
    expect(@player.name).to eq('Foo')
  end
  it "has an id" do
    expect(@player.id).to eq(1)
  end
  it "has a color" do
    expect(@player.color).to eq('white')
  end

  describe '.name='do
    before(:all) { @player = Player.new(1) }
    it "changes the name of the player" do
      expect(@player.name).to eq("Player 1")
      @player.name = "John"
      expect(@player.name).to eq("John")
    end
  end
end

