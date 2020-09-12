# frozen_string_literal: true

module Chess
  class Rook
    def initialize(color)
      @color = color
    end

    def to_s
      return '♜' if @color == :black

      '♖'
    end

    def self.notation
      'R'
    end
  end
end
