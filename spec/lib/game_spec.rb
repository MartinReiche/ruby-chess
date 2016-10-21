require 'spec_helper'
require 'chess'

describe Game do
  it { is_expected.to respond_to(:board) }
  it { is_expected.to respond_to(:players) }
  it { is_expected.to respond_to(:active) }
  
  describe '.new' do
    before(:all) { @game = Game.new }
    it "initializes a Board" do
      expect(@game.board).to be_a(Board)
      f = @game.board.figures_a
      expect(f.flatten.all? {|i| i.nil? }).to be false
    end
    it "initializes Players" do
      expect(@game.players[0].id).to eq(1)
      expect(@game.players[1].id).to eq(2)
    end
  end
end
