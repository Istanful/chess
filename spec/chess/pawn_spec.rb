# frozen_string_literal: true

module Chess
  RSpec.describe Pawn do
    describe '#move_to' do
      context 'when moving one step forward as black' do
        it 'performs that move' do
          pawn = described_class.new(:black, 0, 6)
          board = Board.new [pawn]
          destination = Vector.new(0, 5)

          pawn.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(pawn)
        end

        it 'does not move if space is occupied' do
          white_pawn = described_class.new(:white, 0, 1)
          black_pawn = described_class.new(:black, 0, 2)
          board = Board.new [white_pawn, black_pawn]
          destination = Vector.new(0, 1)

          black_pawn.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(white_pawn)
        end

        it 'does not move in the wrong direction' do
          pawn = described_class.new(:black, 0, 1)
          board = Board.new [pawn]
          destination = Vector.new(0, 2)

          pawn.move_to(board, destination)

          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when moving one step forward as white' do
        it 'performs that move' do
          pawn = described_class.new(:white, 0, 1)
          board = Board.new [pawn]
          destination = Vector.new(0, 2)

          pawn.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(pawn)
        end

        it 'does not move if space is occupied' do
          white_pawn = described_class.new(:white, 0, 1)
          black_pawn = described_class.new(:black, 0, 2)
          board = Board.new [white_pawn, black_pawn]
          destination = Vector.new(0, 2)

          white_pawn.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(black_pawn)
        end

        it 'does not move in the wrong direction' do
          pawn = described_class.new(:white, 0, 1)
          board = Board.new [pawn]
          destination = Vector.new(0, 0)

          pawn.move_to(board, destination)

          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when moving right diagonally as white' do
        it 'performs that move if position is occupied' do
          white_pawn = described_class.new(:white, 0, 1)
          black_pawn = described_class.new(:black, 1, 2)
          board = Board.new [white_pawn, black_pawn]
          destination = Vector.new(1, 2)

          white_pawn.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(white_pawn)
        end

        it 'does not perform that move if position is free' do
          white_pawn = described_class.new(:white, 0, 1)
          board = Board.new [white_pawn]
          destination = Vector.new(1, 2)

          white_pawn.move_to(board, destination)

          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when moving right diagonally as black' do
        it 'performs that move if position is occupied' do
          black_pawn = described_class.new(:black, 1, 2)
          white_pawn = described_class.new(:white, 0, 1)
          board = Board.new [white_pawn, black_pawn]
          destination = Vector.new(0, 1)

          black_pawn.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(black_pawn)
        end

        it 'does not perform that move if position is free' do
          black_pawn = described_class.new(:black, 1, 2)
          board = Board.new [black_pawn]
          destination = Vector.new(0, 1)

          black_pawn.move_to(board, destination)

          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when moving two steps as white' do
        it 'performs that move if it has not moved' do
          pawn = described_class.new(:white, 0, 1)
          board = Board.new [pawn]
          destination = Vector.new(0, 3)

          pawn.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(pawn)
        end

        it 'does not move if path is obscured' do
          white_pawn = described_class.new(:white, 0, 1)
          black_pawn = described_class.new(:black, 0, 2)
          board = Board.new [white_pawn, black_pawn]
          destination = Vector.new(0, 3)

          white_pawn.move_to(board, destination)

          expect(board.piece_at(destination)).to be_nil
        end

        it 'does not move if it has moved' do
          pawn = described_class.new(:white, 0, 1)
          board = Board.new [pawn]
          destination = Vector.new(0, 4)

          pawn.move_to(board, Vector.new(0, 2))
          pawn.move_to(board, destination)

          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when moving two steps as black' do
        it 'performs that move if it has not moved' do
          pawn = described_class.new(:black, 0, 6)
          board = Board.new [pawn]
          destination = Vector.new(0, 4)

          pawn.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(pawn)
        end

        it 'does not move if path is obscured' do
          black_pawn = described_class.new(:black, 0, 3)
          white_pawn = described_class.new(:white, 0, 2)
          board = Board.new [white_pawn, black_pawn]
          destination = Vector.new(0, 1)

          black_pawn.move_to(board, destination)

          expect(board.piece_at(destination)).to be_nil
        end

        it 'does not move if not in starting position' do
          pawn = described_class.new(:black, 0, 5)
          board = Board.new [pawn]
          destination = Vector.new(0, 2)

          pawn.move_to(board, Vector.new(0, 4))
          pawn.move_to(board, destination)

          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when opposing pawn just moved 2 steps' do
        it 'is capturable by "En Passant"' do
          black_pawn = described_class.new(:black, 1, 3)
          white_pawn = described_class.new(:white, 2, 1)
          board = Board.new [black_pawn, white_pawn]

          white_pawn.move_to(board, Vector.new(2, 3))
          black_pawn.move_to(board, Vector.new(2, 2))

          expect(board.piece_at(Vector.new(2, 2))).to eql(black_pawn)
          expect(board.piece_at(Vector.new(2, 3))).to be_nil
        end
      end

      context 'when opposing pawn moved 2 steps historically' do
        it 'is not capturable by "En Passant"' do
          black_pawn = described_class.new(:black, 1, 4)
          white_pawn_1 = described_class.new(:white, 1, 1)
          white_pawn_2 = described_class.new(:white, 2, 1)
          board = Board.new [white_pawn_1, white_pawn_2, black_pawn]

          white_pawn_2.move_to(board, Vector.new(2, 3))
          black_pawn.move_to(board, Vector.new(1, 3))
          white_pawn_1.move_to(board, Vector.new(1, 2))
          black_pawn.move_to(board, Vector.new(2, 2))

          expect(board.piece_at(Vector.new(1, 3))).to eql(black_pawn)
          expect(board.piece_at(Vector.new(2, 2))).to be_nil
          expect(board.piece_at(Vector.new(2, 3))).to eql(white_pawn_2)
        end
      end
    end
  end
end
