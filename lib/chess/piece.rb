# frozen_string_literal: true

module Chess
  class Piece
    attr_accessor :x
    attr_accessor :y
    attr_accessor :color

    def initialize(color, x, y)
      @color = color
      @x = x
      @y = y
    end

    def self.notation
      'X'
    end

    def to_s
      ' '
    end

    def position
      Vector.new(x, y)
    end

    def move_to(board, destination)
      move = Move.new(self, self.position, destination)
      board.moves << move

      self.x = destination.x
      self.y = destination.y

      true
    end
  end
end
