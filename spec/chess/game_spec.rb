# frozen_string_literal: true

module Chess
  RSpec.describe Game do
    describe '#prompt_text' do
      context 'when it is whites turn' do
        it 'returns the prompt text' do
          game = described_class.new

          text = game.prompt_text

          expect(text).to eql('White move: ')
        end
      end

      context 'when it is blacks turn' do
        it 'returns the prompt text' do
          game = described_class.new
          game.play('a2-a3')

          text = game.prompt_text

          expect(text).to eql('Black move: ')
        end
      end

      context 'when a pawn is to be promoted' do
        it 'returns the prompt text' do
          pawn = Chess::Pawn.new(:white, 0, 6)
          board = Board.new [pawn]
          game = described_class.new(board)
          game.play('a7-a8')
          game.play('Q')

          text = game.prompt_text

          expect(text).to eql('Promote to which piece? [QRBN]: ')
        end
      end

      context 'when given an invalid promotion' do
        it 'returns a descriptive message' do
          pawn = Chess::Pawn.new(:white, 0, 6)
          board = Board.new [pawn]
          game = described_class.new(board)
          game.play('a7-a8')
          game.play('X')

          text = game.prompt_text

          expect(text).to eql(
            "\"X\" is not a valid piece.\n" +
            "Please choose one of (Q)ueen, k(N)ight, (B)ishop or (R)ook.\n" +
            'Promote to which piece? [QRBN]: '
          )
        end
      end

      context 'when given an invalid move' do
        it 'returns a descriptive message' do
          game = described_class.new
          game.play('shushkebab')

          text = game.prompt_text

          expect(text).to eql(
            '"shushkebab" is not a valid move.' +
            "\nWhite move: "
          )
        end
      end

      context 'when given an illegal move' do
        it 'returns a descriptive message' do
          game = described_class.new
          game.play('a2-a6')

          text = game.prompt_text

          expect(text).to eql(
            '"a2-a6" is not a legal move.' +
            "\nWhite move: "
          )
        end
      end

      context 'when given a move for the opponent' do
        it 'returns a descriptive error' do
          game = described_class.new
          game.play('h7-h6')

          text = game.prompt_text

          expect(text).to eql(
            '"h7-h6" is not a valid move since it would move the opponent.' +
            "\nWhite move: "
          )
        end
      end

      context 'when given a move where no piece exists' do
        it 'returns a descriptive error' do
          game = described_class.new
          game.play('a3-a4')

          text = game.prompt_text

          expect(text).to eql(
            "No piece to move for \"a3-a4\"." +
            "\nWhite move: "
          )
        end
      end

      context 'when putting its king in check' do
        it 'returns a descriptive error' do
          white_king = King.new(:white, 0, 0)
          black_rook = Rook.new(:black, 1, 1)
          board = Board.new [white_king, black_rook]
          game = described_class.new board
          game.play('a1-a2')

          text = game.prompt_text

          expect(text).to eql(
            "Move would put white king in check." +
            "\nWhite move: "
          )
        end
      end
    end

    describe '#play' do
      context 'when putting its king in check' do
        it 'does not perform that move' do
          white_king = King.new(:white, 0, 0)
          black_bishop = Bishop.new(:black, 0, 1)
          black_rook = Rook.new(:black, 1, 1)
          board = Board.new [white_king, black_rook, black_bishop]
          game = described_class.new board
          game.play('a1-a2')

          text = game.prompt_text

          expect(board.piece_at(Vector.new(0, 0))).to eql(white_king)
          expect(board.piece_at(Vector.new(1, 1))).to eql(black_rook)
          expect(board.piece_at(Vector.new(0, 1))).to eql(black_bishop)
        end
      end

      context 'when given a valid move' do
        it 'plays the given move' do
          board = Board.new
          game = described_class.new(board)

          game.play('a2-a4')

          expect(board.to_s).to eql(
            "  abcdefgh  \n" +
            "            \n" +
            "8 ♖♘♗♕♔♗♘♖ 8\n" +
            "7 ♙♙♙♙♙♙♙♙ 7\n" +
            "6          6\n" +
            "5          5\n" +
            "4 ♟        4\n" +
            "3          3\n" +
            "2  ♟♟♟♟♟♟♟ 2\n" +
            "1 ♜♞♝♛♚♝♞♜ 1\n" +
            "            \n" +
            "  abcdefgh  \n"
          )
        end
      end

      context 'when a pawn is to be promoted' do
        it 'accepts promotion' do
          pawn = Chess::Pawn.new(:white, 0, 6)
          board = Board.new [pawn]
          game = described_class.new(board)

          game.play('a7-a8')
          game.play('Q')

          expect(board.to_s).to eql(
            "  abcdefgh  \n" +
            "            \n" +
            "8 ♛        8\n" +
            "7          7\n" +
            "6          6\n" +
            "5          5\n" +
            "4          4\n" +
            "3          3\n" +
            "2          2\n" +
            "1          1\n" +
            "            \n" +
            "  abcdefgh  \n"
          )
        end
      end
    end
  end
end
