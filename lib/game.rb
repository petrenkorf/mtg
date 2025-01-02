require_relative './cards/collection/island'
require_relative './cards/collection/mountain'
require_relative './player'

class TurnPhase
  class << self
    def run(interface, player)
      interface.display "#{self} for #{player.name}"
      player.battlefield.each { |c| puts "desvira card #{c}" }
    end
  end
end

class UntapPhase < TurnPhase; end
class UpkeepPhase < TurnPhase; end

class MainPhase < TurnPhase
  class << self
    def run(interface, player)
      interface.display "#{self} for #{player.name}"
    end
  end
end

class DrawPhase < TurnPhase
  class << self
    def run(interface, player)
      interface.display "#{self} for #{player.name}"
      player.draw_card
      sleep 0.25
    end
  end
end

class Game
  TURN_PHASES = [UntapPhase,
                 UpkeepPhase,
                 DrawPhase,
                 MainPhase].freeze

  def initialize(game_interface)
    @game_interface = game_interface
    @player1 = Player.new(
      name: 'petris',
      deck: Array.new(60) { ::Island.new },
      hand: [],
      battlefield: []
    )
    @player2 = Player.new(
      name: 'gabriel',
      deck: Array.new(60) { ::Island.new },
      hand: [],
      battlefield: []
    )
  end

  def start
    prepare
    start_game
  end

  def prepare
    @player1.draw_initial_hand
    @player2.draw_initial_hand
    @game_interface.display @player1.hand
    @current_phase = 0
  end

  def start_game
    current_player = @player1
    loop do
      TURN_PHASES[@current_phase].run @game_interface, current_player
      if @current_phase == TURN_PHASES.count - 1
        @current_phase = 0
        current_player = current_player == @player1 ? @player2 : @player1
      else
        @current_phase += 1
      end
    end
  end
end

class CliInterface
  def display(data)
    puts data
  end

  def ask_input
    gets
  end
end

g = Game.new(CliInterface.new)
g.start
