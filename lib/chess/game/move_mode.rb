# frozen_string_literal: true

module Chess
  class Game
    class MoveMode
      INPUT_LENGTH = 5
      INPUT_PATTERN = /[a-h][1-8]\-[a-h][1-8]/

      def initialize(game, error = "")
        @game = game
        @board = game.board
        @error = error
      end

      def prompt_text
        "#{@error}#{@game.current_player.capitalize} move: "
      end

      def play(move_str)
        error = validate_input(move_str)

        return MoveMode.new(@game, error) unless error.nil?

        from, to = parse_input(move_str)
        successful = @board.move(from, to)

        error = "\"#{move_str}\" is not a legal move.\n"
        return MoveMode.new(@game, error) unless successful
        return PromotionMode.new(@game) if promote_pawn?

        @game.switch_player
        MoveMode.new(@game)
      end

      private

      def promote_pawn?
        last_piece = @board.moves.last.piece
        last_piece.kind_of?(Pawn) && ([7, 0].include?(last_piece.y))
      end

      def parse_input(input)
        from, to = *input.split('-')
        [parse_vector(from), parse_vector(to)]
      end

      def illegal_input_pattern?(input)
        !(INPUT_PATTERN.match?(input) && input.length == INPUT_LENGTH)
      end

      def opposing_move?(input)
        from, to = parse_input(input)
        @board.piece_at(from).color != @game.current_player
      end

      def no_piece?(input)
        from, to = parse_input(input)
        !@board.piece_at(from)
      end

      def validate_input(input)
        if illegal_input_pattern?(input)
          return "\"#{input}\" is not a valid move.\n"
        end

        if no_piece?(input)
          return "No piece to move for \"#{input}\".\n"
        end

        if opposing_move?(input)
          "\"#{input}\" is not a valid move since it would move the opponent.\n"
        end
      end

      def parse_vector(str)
        x_char, y_char = *str.chars
        x = "abcdefgh".index(x_char)
        y = y_char.to_i - 1
        Chess::Vector.new(x, y)
      end
    end
  end
end
