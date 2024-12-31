class Mana
  attr_reader :colors

  alias color colors

  def initialize(colors)
    @colors = colors
  end

  def matches(color)
    (@colors + [:colorless]).include?(color)
  end
end
