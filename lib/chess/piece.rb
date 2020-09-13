# frozen_string_literal: true

require "chess/rook"
require "chess/knight"
require "chess/bishop"
require "chess/queen"
require "chess/king"
require "chess/pawn"
require "chess/blank"

module Chess
  module Piece
    PIECE_CLASSES = [
      Chess::Rook,
      Chess::Knight,
      Chess::Bishop,
      Chess::Queen,
      Chess::King,
      Chess::Pawn,
      Chess::Blank,
    ]

    def self.from_notation(notation, *args)
      klass = PIECE_CLASSES.find { |k| k.notation === notation }
      klass.new(*args)
    end
  end
end
