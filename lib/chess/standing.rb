# frozen_string_literal: true

module Chess
  class Standing
    def initialize(game)
      @game = game
      @board = game.board
    end

    def checkmate?
      no_valid_moves? && king_threatened?
    end

    def stalemate?
      return false if king_threatened?

      no_valid_moves?
    end

    private

    def no_valid_moves?
      current_player = @game.current_player
      pieces = @board.pieces.select { |p| p.color == current_player }
      pieces.none? do |piece|
        Board::WIDTH.times.any? do |x|
          Board::HEIGHT.times.any? do |y|
            valid_move = piece.move_to(@board, Vector.new(x, y))
            king_freed = !king_threatened?
            @board.moves.last&.undo(@board) if valid_move
            valid_move && king_freed
          end
        end
      end
    end

    def king_threatened?
      king = @board.pieces.find do |piece|
        piece.color == current_player && piece.kind_of?(King)
      end

      return false if king.nil?

      @board.pieces.any? do |piece|
        piece.color != current_player && piece.threatens?(@board, king.position)
      end
    end

    def current_player
      @game.current_player
    end
  end
end
