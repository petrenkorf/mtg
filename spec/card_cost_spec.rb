require 'spec_helper'
require 'card_cost'
require 'mana_cost'
require 'land'

RSpec.describe CardCost do
  let(:blue)      { ManaCost.new(:blue) }
  let(:colorless) { ManaCost.new(:colorless) }

  describe '#card_cost' do
    context 'when card_cost costs 2 blue mana' do
      subject(:card_cost) { CardCost.new(blue, blue) }

      it { expect(card_cost.costs).to eq [blue, blue] }
      it { expect(card_cost.costs).to be_an Array }
      it { expect(card_cost.converted_cost).to eq 2 }
    end
  end

  describe '#converted_cost' do
    context 'when card_cost costs 2 blue mana' do
      subject(:card_cost) { CardCost.new(blue, blue) }

      it { expect(card_cost.converted_cost).to eq 2 }
    end

    context 'when card_cost costs 1 blue mana' do
      subject(:card_cost) { CardCost.new(blue) }

      it { expect(card_cost.converted_cost).to eq 1 }
    end
  end

  describe '#castable?' do
    let(:island)    { Land.new(:blue) }
    let(:mountain)  { Land.new(:red) }
    let(:dual_land) { Land.new(:blue, :red) }

    let(:double_island)                 { [island, island] }
    let(:double_mountain)               { [mountain, mountain] }
    let(:double_island_single_mountain) { [island, island, mountain] }
    let(:island_and_dual)               { [island, dual_land] }
    let(:single_island)                 { [island] }
    let(:single_mountain)               { [mountain] }
    let(:single_island_single_mountain) { [island, mountain] }
    let(:double_dual)                   { [dual_land, dual_land] }

    context 'when card_cost costs 2 blue mana' do
      let(:card_cost) { CardCost.new(blue, blue) }

      describe 'valid terrain combinations' do
        it { expect(card_cost.castable?(double_island)).to be true }
        it { expect(card_cost.castable?(double_island_single_mountain)).to be true }
        it { expect(card_cost.castable?(island_and_dual)).to be true }
      end

      describe 'invalid terrain combinations' do
        it { expect(card_cost.castable?(single_island)).to be false }
        it { expect(card_cost.castable?(single_island_single_mountain)).to be false }
        it { expect(card_cost.castable?(double_mountain)).to be false }
      end
    end

    context 'when card_cost costs 2 colorless mana' do
      let(:card_cost) { CardCost.new(colorless, colorless) }

      describe 'valid terrain combinations' do
        it { expect(card_cost.castable?(double_island)).to be true }
        it { expect(card_cost.castable?(double_mountain)).to be true }
        it { expect(card_cost.castable?(double_dual)).to be true }
        it { expect(card_cost.castable?(single_island_single_mountain)).to be true }
      end

      describe 'invalid terrain combinations' do
        it { expect(card_cost.castable?(single_mountain)).to be false }
      end
    end
  end
end
