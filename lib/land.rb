class Land
  attr_reader :mana_color

  alias generates mana_color

  def initialize(mana_color)
    @mana_color = mana_color
  end
end
