# frozen_string_literal: true

require 'chess/move'

module Chess
  class Pawn < Piece
    def to_s
      return '♙' if @color == :black

      '♟'
    end

    def self.notation
      ''
    end

    def move_to(board, destination)
      return true if capture(board, destination)
      return true if capture_by_en_passant(board, destination)
      return false if illegal_move?(board, destination)

      move_to_position(board, destination)
    end

    private

    def move_to_position(board, destination)
      move = Move.new(self, self.position, destination)
      board.moves << move

      self.x = destination.x
      self.y = destination.y

      true
    end

    def illegal_move?(board, destination)
      board.piece_at(destination) ||
        illegal_direction?(destination) ||
        illegal_jump?(board, destination)
    end

    def illegal_jump?(board, destination)
      delta_y = destination.y - y
      delta_y.abs > 1 &&
        board.moves.select { |move| move.piece == self }.any? ||
        board.pieces_between(position, destination).any?
    end

    def illegal_direction?(destination)
      delta_y = destination.y - y
      destination.x != x ||
        ![legal_y_direction, legal_y_direction * 2].include?(delta_y)
    end

    def capture(board, destination)
      return false unless capturable?(board, destination)

      board.remove_piece(destination)
      move_to_position(board, destination)
    end

    def capture_by_en_passant(board, destination)
      return false unless capturable_by_en_passant?(board, destination)

      capture_position = destination - Vector.new(0, legal_y_direction)
      board.remove_piece(capture_position)

      move_to_position(board, destination)
    end

    def capturable_by_en_passant?(board, destination)
      capture_position = destination - Vector.new(0, legal_y_direction)
      capturable_piece = board.piece_at(capture_position)
      last_move = board.moves.last

      return false if capturable_piece.nil?
      return false if capturable_piece.color == color
      return false if last_move.nil?

      last_move.piece == capturable_piece &&
        last_move.delta.y.abs == 2 &&
        capturable_piece.kind_of?(Pawn) &&
        diagonal_move?(destination)
    end

    def diagonal_move?(destination)
      [x + 1, x - 1].include?(destination.x) &&
        destination.y == (y + legal_y_direction)
    end

    def capturable?(board, destination)
      capturable_piece = board.piece_at(destination)
      return if capturable_piece.nil?
      return if capturable_piece.color == color

      diagonal_move?(destination)
    end

    def legal_y_direction
      return -1 if @color === :black

      1
    end
  end
end
