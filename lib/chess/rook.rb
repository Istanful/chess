# frozen_string_literal: true

require "chess/piece"

module Chess
  class Rook < Piece
    def to_s
      return '♖' if @color == :black

      '♜'
    end

    def self.notation
      'R'
    end

    def position
      Vector.new(x, y)
    end

    def threatens?(board, point)
      legal_destination?(board, point)
    end

    def move_to(board, destination)
      return false unless legal_destination?(board, destination)
      return true if capture(board, destination)

      super(board, destination)
    end

    private

    def legal_destination?(board, destination)
      delta = destination - position
      return false unless [delta.y, delta.x].include? 0
      return false if board.pieces_between(position, destination).any?
      return true if capturable?(board, destination)

      !board.piece_at(destination)
    end

    def capturable?(board, destination)
      capturable_piece = board.piece_at(destination)
      return false if capturable_piece.nil?

      capturable_piece.color != color
    end

    def capture(board, destination)
      return false unless capturable?(board, destination)

      board.remove_piece(destination)
      move_to(board, destination)
    end
  end
end
