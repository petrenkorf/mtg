require 'spec_helper'
require 'creature'
require 'land'

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
    let(:island)    { Land.new(:blue) }
    let(:mountain)  { Land.new(:red) }
    let(:dual_land) { Land.new(:blue, :red) }
    let(:double_island) { [island, island] }
    let(:double_mountain) { [mountain, mountain] }
    let(:double_island_single_mountain) { [island, island, mountain] }
    let(:island_and_dual) { [island, dual_land] }
    let(:single_island) { [island] }
    let(:single_mountain) { [mountain] }
    let(:single_island_single_mountain) { [island, mountain] }

    context 'when creature costs 2 blue mana' do
      let(:creature) { Creature.new.set_cost(%i[blue blue]) }

      describe 'valid terrain combinations' do
        it { expect(creature.castable?(double_island)).to be true }
        it { expect(creature.castable?(double_island_single_mountain)).to be true }
        it { expect(creature.castable?(island_and_dual)).to be true }
      end

      describe 'invalid terrain combinations' do
        it { expect(creature.castable?(single_island)).to be false }
        it { expect(creature.castable?(single_island_single_mountain)).to be false }
        it { expect(creature.castable?(double_mountain)).to be false }
      end
    end

    context 'when creature costs 2 colorless mana' do
      let(:creature) { Creature.new.set_cost(%i[colorless colorless]) }

      describe 'valid terrain combinations' do
        it { expect(creature.castable?(double_island)).to be true }
        it { expect(creature.castable?(single_island_single_mountain)).to be true }
      end

      describe 'invalid terrain combinations' do
        it { expect(creature.castable?(single_mountain)).to be false }
      end
    end
  end
end
