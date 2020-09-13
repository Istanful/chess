# frozen_string_literal: true

module Chess
  class Game
    attr_reader :board
    attr_reader :current_player

    def initialize(board = Board.new)
      @board = board
      @mode = :move
      @current_player = :white
    end

    def prompt_text
      "#{current_player.capitalize} move: "
    end

    def play(move_str)
      if @mode == :promote_pawn
        last_piece = @board.moves.last.piece
        promoted_piece = PieceHelper.piece_from(move_str, last_piece.color, last_piece.x, last_piece.y)
        @board.remove_piece(Vector.new(last_piece.x, last_piece.y))
        @board.add_piece(promoted_piece)
        switch_player
        return
      end

      from, to = *move_str.split('-')
      @board.move parse_vector(from), parse_vector(to)
      last_piece = @board.moves.last.piece

      if last_piece.kind_of?(Pawn) && ([7, 0].include?(last_piece.y))
        @mode = :promote_pawn
      else
        switch_player
      end
    end

    private

    def switch_player
      return @current_player = :black if @current_player == :white

      @current_player = :white
    end

    def parse_vector(str)
      x_char, y_char = *str.chars
      x = "abcdefgh".index(x_char)
      y = y_char.to_i - 1
      Chess::Vector.new(x, y)
    end
  end
end
