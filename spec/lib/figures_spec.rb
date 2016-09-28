require 'spec_helper'
require 'chess'

describe Figure do
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:player) }
  it { is_expected.to respond_to(:player_id) }
  it { is_expected.to respond_to(:type) }
  
  
end

describe Knight do
  it { expect(Knight).to be < Figure }
end
