# frozen_string_literal: true

module Chess
  class Knight < Piece
    def to_s
      return '♘' if @color == :black

      '♞'
    end

    def self.notation
      'N'
    end
  end
end
