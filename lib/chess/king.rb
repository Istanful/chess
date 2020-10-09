# frozen_string_literal: true

module Chess
  class King < Piece
    MAX_SQUARE_ADVANCE = 1

    def to_s
      return '♔' if @color == :black

      '♚'
    end

    def self.notation
      'K'
    end

    def move_to(board, destination)
      return true if capture(board, destination)
      return true if perform_castling(board, destination)
      return false if board.piece_at(destination)
      return false if unreachable?(destination)

      super(board, destination)
    end

    def threatens?(_, point)
      reachable?(point)
    end

    private

    def capture(board, destination)
      capturable_piece = board.piece_at(destination)
      return false if capturable_piece.nil?
      return false if capturable_piece.color == color

      Move.new(self, position, destination, capturable_piece)
          .perform(board)
    end

    def reachable?(destination)
      !unreachable?(destination)
    end

    def unreachable?(destination)
      delta = destination - position
      [delta.x, delta.y].any? { |dimension| dimension.abs > MAX_SQUARE_ADVANCE }
    end

    def perform_castling(board, destination)
      delta = destination - position
      rook = casteable_rook(board, destination)
      return false unless delta.x.abs == 2
      return false if rook.nil?
      return false if board.pieces_between(position, destination).any?
      return false if board.moves.any? { |move| move.piece == self }
      return false if threatening_pieces_on_path?(board, destination)

      path = Path.new(position, destination)
      rook.move_to(board, path.plot[1])
      set_position(board, destination)
    end

    def casteable_rook(board, destination)
      rook = board.piece_at(destination + Vector.new(1, 0)) || board.piece_at(destination - Vector.new(2, 0))

      return nil if rook.nil?
      return nil unless rook.kind_of?(Rook)
      return nil unless rook.color == color
      return nil if board.moves.any? { |move| move.piece == rook }

      rook
    end

    def threatening_pieces_on_path?(board, destination)
      path = Path.new(position, destination)
      path.plot.any? do |point|
        other_pieces = board.pieces - [self]
        other_pieces.any? do |piece|
          piece.color != color && piece.threatens?(board, point)
        end
      end
    end

    def set_position(board, destination)
      move = Move.new(self, self.position, destination)
      board.moves << move

      self.x = destination.x
      self.y = destination.y

      true
    end
  end
end
