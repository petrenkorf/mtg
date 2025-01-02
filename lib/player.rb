class Player
  attr_reader :deck, :hand, :battlefield, :name

  def initialize(deck:, hand:, battlefield:, name:)
    @name = name
    @deck = deck
    @hand = hand
    @battlefield = battlefield
  end

  def draw_card
    raise '#{@name} Lost! Not more cards to draw' if @deck.count == 0

    @hand << @deck.pop
  end

  def draw_initial_hand = 7.times { draw_card }
end
