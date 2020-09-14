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
      return false unless available_destinations.include?(destination)
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
