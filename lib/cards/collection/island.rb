require_relative '../../card_cost'

class Island
  def initialize
    @costs = CardCost.new
  end

  def to_s
    self.class.name
  end
end