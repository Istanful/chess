# frozen_string_literal: true

require "chess/game/move_mode"
require "chess/game/promotion_mode"
require "chess/game/finish_mode"

module Chess
  class Game
    attr_reader :board
    attr_reader :current_player

    def initialize(board = Board.new)
      @board = board
      @current_player = :white
      @input_mode = MoveMode.new(self)
      @finished = false
    end

    def prompt_text
      @input_mode.prompt_text
    end

    def play(move_str)
      @input_mode = @input_mode.play(move_str)
    end

    def finished?
      @finished
    end

    def finish
      @finished = true
    end

    def switch_player
      @current_player = next_player
    end

    def next_player
      return :black if @current_player == :white

      :white
    end
  end
end
