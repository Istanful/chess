# frozen_string_literal: true

module Chess
  class Game
    class FinishMode
      attr_reader :game

      def initialize(game)
        @game = game
      end

      def prompt_text
        "#{@game.next_player.capitalize} won!"
      end
    end
  end
end
