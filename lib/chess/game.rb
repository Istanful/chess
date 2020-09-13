# frozen_string_literal: true

module Chess
  class Game
    def initialize(board = Board.new)
      @board = board
      @mode = :move
    end

    def play(move_str)
      if @mode == :promote_pawn
        last_piece = @board.moves.last.piece
        promoted_piece = Piece.from_notation(move_str, last_piece.color, last_piece.x, last_piece.y)
        @board.remove_piece(Vector.new(last_piece.x, last_piece.y))
        @board.add_piece(promoted_piece)
        return
      end

      from, to = *move_str.split('-')
      @board.move parse_vector(from), parse_vector(to)
      last_piece = @board.moves.last.piece

      if last_piece.kind_of?(Pawn) && ([7, 0].include?(last_piece.y))
        @mode = :promote_pawn
      end
    end

    private

    def parse_vector(str)
      x_char, y_char = *str.chars
      x = "abcdefgh".index(x_char)
      y = y_char.to_i - 1
      Chess::Vector.new(x, y)
    end
  end
end
