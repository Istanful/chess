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
      return false unless legal_destination?(board, destination)
      return true if capture(board, destination)

      super(board, destination)
    end

    def threatens?(board, point)
      legal_destination?(board, point)
    end

    private

    def legal_destination?(board, destination)
      return false if board.pieces_between(position, destination).any?
      return false if invalid_angle?(destination)
      return true if capturable?(board, destination)

      board.piece_at(destination).nil?
    end

    def capturable?(board, destination)
      capturable_piece = board.piece_at(destination)
      return false if capturable_piece.nil?

      capturable_piece.color != color
    end

    def capture(board, destination)
      capturable_piece = board.piece_at(destination)
      return false if capturable_piece.nil?
      return false if capturable_piece.color == color

      Move.new(self, position, destination, capturable_piece)
          .perform(board)
    end

    def invalid_angle?(destination)
      delta = destination - position
      VALID_ANGLES.none? do |angle|
        angle.round(2) == delta.angle.round(2)
      end
    end
  end
end
