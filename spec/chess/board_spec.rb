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
            "8 ♜♞♝♛♚♝♞♜ 8\n" +
            "7 ♟♟♟♟♟♟♟♟ 7\n" +
            "6          6\n" +
            "5          5\n" +
            "4          4\n" +
            "3          3\n" +
            "2 ♙♙♙♙♙♙♙♙ 2\n" +
            "1 ♖♘♗♕♔♗♘♖ 1\n" +
            "            \n" +
            "  abcdefgh  \n"
          )
        end
      end
    end
  end
end
