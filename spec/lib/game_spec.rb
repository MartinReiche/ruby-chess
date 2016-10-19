require 'spec_helper'
require 'chess'

describe Game do
  it { is_expected.to respond_to(:board) }
  it { is_expected.to respond_to(:players) }
  
  

end
