require 'spec_helper'
require 'land'
require 'mana'

RSpec.describe Land do
  subject(:land) { Land.new(:mana_color) }

  describe '#generates' do
    it { expect(land.generates).to be_a Mana }
  end
end
