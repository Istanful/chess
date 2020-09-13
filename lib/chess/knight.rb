# frozen_string_literal: true

module Chess
  class Knight < Piece
    attr_accessor :x
    attr_accessor :y

    def initialize(color, x, y)
      @color = color
      @x = x
      @y = y
    end

    def to_s
      return '♞' if @color == :black

      '♘'
    end

    def self.notation
      'N'
    end
  end
end
