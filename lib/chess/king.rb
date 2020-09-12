# frozen_string_literal: true

module Chess
  class King
    def initialize(color)
      @color = color
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
