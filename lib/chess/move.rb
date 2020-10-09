# frozen_string_literal: true

module Chess
  class Move
    attr_reader :piece
    attr_reader :from
    attr_reader :to
    attr_reader :capture

    def initialize(piece, from, to, capture = nil)
      @piece = piece
      @from = from
      @to = to
      @capture = capture
    end

    def delta
      to - from
    end

    def perform(board)
      board.remove_piece(capture.position) unless capture.nil?

      piece.x = to.x
      piece.y = to.y

      board.moves << self

      true
    end

    def undo(board)
      board.add_piece(capture) unless capture.nil?

      piece.x = from.x
      piece.y = from.y

      board.moves = board.moves.reject { |m| m === self }

      true
    end
  end
end
