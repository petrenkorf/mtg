require 'spec_helper'
require 'creature'

RSpec.describe Creature do
  describe '#cost' do
    context 'when creature costs 2 blue mana' do
      it 'returns 2 blue mana' do
        creature = Creature.new.set_cost(%i[blue blue])

        expect(creature.cost).to eq %i[blue blue]
      end
    end
  end

  describe '#castable?' do
    let(:island) { double('Land', generates: :blue) }
    let(:mountain) { double('Land', generates: :red) }

    let(:creature) { Creature.new.set_cost(%i[blue blue]) }

    describe 'valid terrain combinations' do
      context 'when we do have 2 islands' do
        let(:lands) { [island, island] }

        it { expect(creature.castable?(lands)).to be true }
      end

      context 'when we do have 2 islands and 1 mountain' do
        let(:lands) { [island, island, mountain] }

        it { expect(creature.castable?(lands)).to be true }
      end
    end

    describe 'invalid terrain combinations' do
      context 'when we do have 1 island' do
        let(:lands) { [island] }

        it { expect(creature.castable?(lands)).to be false }
      end

      context 'when we do have 1 island and 1 mountain' do
        let(:lands) { [island, mountain] }

        it { expect(creature.castable?(lands)).to be false }
      end

      context 'when we do have 2 mountain' do
        let(:lands) { [mountain, mountain] }

        it { expect(creature.castable?(lands)).to be false }
      end
    end
  end
end
