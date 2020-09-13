# frozen_string_literal: true

module Chess
  class King
    attr_accessor :x
    attr_accessor :y

    def initialize(color, x, y)
      @color = color
      @x = x
      @y = y
    end

    def to_s
      return '♚' if @color == :black

      '♔'
    end

    def self.notation
      'K'
    end
  end
end
