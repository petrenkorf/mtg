require 'spec_helper'
require 'mana'

RSpec.describe Mana do
  describe '#type' do
    context 'when is blue' do
      subject(:mana) { Mana.new([:blue]) }

      it { expect(mana.color).to eq [:blue] }
      it { expect(mana.color).to be_an Array }
    end
  end

  describe '#matches' do
    context 'when is blue' do
      subject(:mana) { Mana.new([:blue]) }

      it 'matches :blue mana' do
        expect(mana.matches(:blue)).to eq true
      end

      it 'matches :colorless mana' do
        expect(mana.matches(:colorless)).to eq true
      end

      it 'does not match :red mana' do
        expect(mana.matches(:red)).to eq false
      end
    end

    context 'when is blue and red' do
      subject(:mana) { Mana.new(%i[blue red]) }

      it 'matches :red mana' do
        expect(mana.matches(:colorless)).to eq true
      end

      it 'matches :blue mana' do
        expect(mana.matches(:colorless)).to eq true
      end

      it 'matches :colorless mana' do
        expect(mana.matches(:colorless)).to eq true
      end

      it 'does not match :black mana' do
        expect(mana.matches(:black)).to eq false
      end
    end
  end
end
