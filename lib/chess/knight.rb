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
      return true if capturable?(board, destination)
      return false unless board.piece_at(destination).nil?

      available_destinations.include?(destination)
    end

    def capture(board, destination)
      return false unless capturable?(board, destination)

      capturable_piece = board.piece_at(destination)
      Move.new(self, position, destination, capturable_piece)
          .perform(board)
    end

    def capturable?(board, destination)
      capturable_piece = board.piece_at(destination)
      return false if capturable_piece.nil?
      return false unless available_destinations.include?(destination)

      capturable_piece.color != color
    end

    def available_destinations
      [
        Vector.new(position.x + 1, position.y + 2),
        Vector.new(position.x - 1, position.y + 2),
        Vector.new(position.x + 1, position.y - 2),
        Vector.new(position.x - 1, position.y - 2),
        Vector.new(position.x + 2, position.y + 1),
        Vector.new(position.x - 2, position.y + 1),
        Vector.new(position.x + 2, position.y - 1),
        Vector.new(position.x - 2, position.y - 1),
      ]
    end
  end
end
