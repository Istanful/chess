# frozen_string_literal: true

module Chess
  class Knight
    def initialize(color)
      @color = color
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
