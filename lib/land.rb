require_relative './mana'

class Land
  attr_reader :mana_color

  alias generates mana_color

  def initialize(*mana_colors)
    @mana_colors = mana_colors
  end

  def generates
    Mana.new(@mana_colors)
  end
end
