# frozen_string_literal: true

module Chess
  class Queen < Piece
    def to_s
      return '♛' if @color == :black

      '♕'
    end

    def self.notation
      'Q'
    end
  end
end
