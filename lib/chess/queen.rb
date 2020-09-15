# frozen_string_literal: true

module Chess
  class Queen < Piece
    VALID_ANGLES = [
      -Math::PI / 4,
      -Math::PI / 2,
      0,
      Math::PI / 2,
      Math::PI / 4,
    ]

    def to_s
      return '♕' if @color == :black

      '♛'
    end

    def self.notation
      'Q'
    end

    def move_to(board, destination)
      return false if board.pieces_between(position, destination).any?
      return false if invalid_angle?(destination)
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

    def invalid_angle?(destination)
      delta = destination - position
      VALID_ANGLES.none? do |angle|
        angle.round(2) == delta.angle.round(2)
      end
    end
  end
end
