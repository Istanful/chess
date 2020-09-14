# frozen_string_literal: true

module Chess
  class Bishop < Piece
    def to_s
      return '♗' if @color == :black

      '♝'
    end

    def self.notation
      'B'
    end

    def move_to(board, destination)
      return false unless diagonal_move?(destination)
      return false if board.pieces_between(position, destination).any?
      return true if capture(board, destination)
      return false if board.piece_at(destination)

      super(board, destination)
    end

    private

    def capture(board, destination)
      capturable_piece = board.piece_at(destination)
      return false if capturable_piece.nil?
      return false if capturable_piece.color == color

      board.remove_piece(destination)
      move_to(board, destination)
    end

    def diagonal_move?(destination)
      delta = destination - position
      delta.x.abs == delta.y.abs
    end
  end
end
