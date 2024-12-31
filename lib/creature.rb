class Creature
  attr_reader :cost

  def set_cost(cost)
    @cost = cost

    self
  end

  def castable?(lands)
    available_mana = lands.map(&:generates)
    card_cost = @cost

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
