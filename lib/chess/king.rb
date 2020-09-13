# frozen_string_literal: true

module Chess
  class King < Piece
    def to_s
      return '♚' if @color == :black

      '♔'
    end

    def self.notation
      'K'
    end
  end
end
