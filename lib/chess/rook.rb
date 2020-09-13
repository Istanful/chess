# frozen_string_literal: true

require "chess/piece"

module Chess
  class Rook < Piece
    def to_s
      return '♜' if @color == :black

      '♖'
    end

    def self.notation
      'R'
    end

    def position
      Vector.new(x, y)
    end

    def move_to(board, destination)
      delta = destination - position

      return false if ![delta.y, delta.x].include? 0
      return false if board.pieces_between(position, destination).any?
      return true if capture(board, destination)
      return false if board.piece_at(destination)

      super(board, destination)
    end

    def capture(board, destination)
      capturable_piece = board.piece_at(destination)
      return false if capturable_piece.nil?
      return false if capturable_piece.color == color

      board.remove_piece(destination)
      move_to(board, destination)
    end
  end
end
