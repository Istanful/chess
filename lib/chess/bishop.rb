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
      return false unless legal_destination?(board, destination)
      return true if capture(board, destination)

      super(board, destination)
    end

    def threatens?(board, destination)
      legal_destination?(board, destination)
    end

    private

    def legal_destination?(board, destination)
      return false unless diagonal_move?(destination)
      return false if board.pieces_between(position, destination).any?
      return true if capturable?(board, destination)

      board.piece_at(destination).nil?
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

    def diagonal_move?(destination)
      delta = destination - position
      delta.x.abs == delta.y.abs
    end
  end
end
