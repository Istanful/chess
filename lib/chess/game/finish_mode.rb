# frozen_string_literal: true

module Chess
  class Game
    class FinishMode
      attr_reader :game

      def initialize(game)
        @game = game
        @standing = game.standing
      end

      def prompt_text
        return "No available moves. It's a draw!" if @standing.stalemate?

        "#{@game.next_player.capitalize} won!"
      end

      def play(_)
      end
    end
  end
end
