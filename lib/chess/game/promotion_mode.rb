# frozen_string_literal: true

module Chess
  class Game
    class PromotionMode
      def initialize(game, error = '')
        @game = game
        @board = game.board
        @error = error
      end

      def prompt_text
        "#{@error}Promote to which piece? [QRBN]: "
      end

      def play(promotion_string)
        error = validate_input(promotion_string)

        return PromotionMode.new(@game, error) unless error.nil?

        last_piece = @board.moves.last.piece
        promoted_piece = PieceHelper.piece_from(promotion_string, last_piece.color, last_piece.x, last_piece.y)
        @board.remove_piece(Vector.new(last_piece.x, last_piece.y))
        @board.add_piece(promoted_piece)
        @game.switch_player

        return FinishMode.new(@game) if lost?

        MoveMode.new(@game)
      end

      private

      def lost?
        return false unless king_threatened?

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

      def validate_input(input)
        return if PieceHelper::PIECE_CLASSES.map(&:notation).include?(input)

        "\"#{input}\" is not a valid piece.\n" +
        "Please choose one of (Q)ueen, k(N)ight, (B)ishop or (R)ook.\n"
      end
    end
  end
end
