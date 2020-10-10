# frozen_string_literal: true

module Chess
  RSpec.describe Board do
    describe '#to_s' do
      context 'when board is new' do
        it 'returns the string representation' do
          board = described_class.new

          string = board.to_s

          expect(string).to eql(
            "  abcdefgh  \n" +
            "            \n" +
            "8 ♖♘♗♕♔♗♘♖ 8\n" +
            "7 ♙♙♙♙♙♙♙♙ 7\n" +
            "6 ■□■□■□■□ 6\n" +
            "5 □■□■□■□■ 5\n" +
            "4 ■□■□■□■□ 4\n" +
            "3 □■□■□■□■ 3\n" +
            "2 ♟♟♟♟♟♟♟♟ 2\n" +
            "1 ♜♞♝♛♚♝♞♜ 1\n" +
            "            \n" +
            "  abcdefgh  \n"
          )
        end
      end

      describe '#move' do
        context 'when given a valid move' do
          it 'moves that piece' do
            board = described_class.new

            board.move(Vector.new(0, 1), Vector.new(0, 2))

            expect(board.to_s).to eql(
              "  abcdefgh  \n" +
              "            \n" +
              "8 ♖♘♗♕♔♗♘♖ 8\n" +
              "7 ♙♙♙♙♙♙♙♙ 7\n" +
              "6 ■□■□■□■□ 6\n" +
              "5 □■□■□■□■ 5\n" +
              "4 ■□■□■□■□ 4\n" +
              "3 ♟■□■□■□■ 3\n" +
              "2 ■♟♟♟♟♟♟♟ 2\n" +
              "1 ♜♞♝♛♚♝♞♜ 1\n" +
              "            \n" +
              "  abcdefgh  \n"
            )
          end

          it 'saves that move' do
            board = described_class.new

            action = -> { board.move(Vector.new(0, 1), Vector.new(0, 2)) }

            expect(action).to change(board.moves, :size)
          end
        end

        context 'when given an invalid move' do
          it 'does not move that piece' do
            board = described_class.new

            board.move(Vector.new(0, 1), Vector.new(0, 4))

            expect(board.to_s).to eql(
              "  abcdefgh  \n" +
              "            \n" +
              "8 ♖♘♗♕♔♗♘♖ 8\n" +
              "7 ♙♙♙♙♙♙♙♙ 7\n" +
              "6 ■□■□■□■□ 6\n" +
              "5 □■□■□■□■ 5\n" +
              "4 ■□■□■□■□ 4\n" +
              "3 □■□■□■□■ 3\n" +
              "2 ♟♟♟♟♟♟♟♟ 2\n" +
              "1 ♜♞♝♛♚♝♞♜ 1\n" +
              "            \n" +
              "  abcdefgh  \n"
            )
          end

          it 'does not save that move' do
            board = described_class.new

            action = -> { board.move(Vector.new(0, 1), Vector.new(0, 4)) }

            expect(action).not_to change(board.moves, :size)
          end
        end
      end
    end
  end
end
