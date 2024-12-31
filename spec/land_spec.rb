require 'spec_helper'
require 'land'

RSpec.describe Land do
  subject(:land) { Land.new(:mana_color) }

  describe '#generates' do
    context 'when land is island' do
      let(:mana_color) { :blue }

      it { expect(land.generates).to eq :mana_color }
    end

    context 'when land is mountain' do
      let(:mana_color) { :red }

      it { expect(land.generates).to eq :mana_color }
    end
  end
end
