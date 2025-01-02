class CardCost
  attr_reader :costs

  def initialize(*costs)
    @costs = costs
  end

  def converted_mana_cost
    @costs.size
  end

  def castable?(lands)
    available_mana = lands.map(&:generates)
    card_cost = @costs

    loop do
      cur_mana = card_cost.pop
      cur_mana_index = available_mana.find_index { |mana| mana.matches cur_mana.color }

      return false unless cur_mana_index

      available_mana.delete_at cur_mana_index

      break if card_cost.empty?
    end

    true
  end
end
