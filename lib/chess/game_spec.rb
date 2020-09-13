# frozen_string_literal: true

module Chess
  RSpec.describe Game do
    describe '#play' do
      context 'when given a valid move' do
        it 'plays the given move' do
          board = Board.new
          game = described_class.new(board)

          game.play('a2-a4')

          expect(board.to_s).to eql(
            "  abcdefgh  \n" +
            "            \n" +
            "8 ♜♞♝♛♚♝♞♜ 8\n" +
            "7 ♟♟♟♟♟♟♟♟ 7\n" +
            "6          6\n" +
            "5          5\n" +
            "4 ♙        4\n" +
            "3          3\n" +
            "2  ♙♙♙♙♙♙♙ 2\n" +
            "1 ♖♘♗♕♔♗♘♖ 1\n" +
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
            "8 ♕        8\n" +
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
