# frozen_string_literal: true

require "chess/game/move_mode"
require "chess/game/promotion_mode"

module Chess
  class Game
    attr_reader :board
    attr_reader :current_player

    def initialize(board = Board.new)
      @board = board
      @current_player = :white
      @input_mode = MoveMode.new(self)
    end

    def prompt_text
      @input_mode.prompt_text
    end

    def play(move_str)
      @input_mode = @input_mode.play(move_str)
    end

    def switch_player
      return @current_player = :black if @current_player == :white

      @current_player = :white
    end
  end
end
