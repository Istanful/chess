# frozen_string_literal: true

module Chess
  RSpec.describe Queen do
    it_behaves_like 'a piece'

    describe '#threatens?' do
      context 'when given a square it can move to' do
        it 'threatens that square' do
          queen = described_class.new(:white, 0, 0)
          board = Board.new [queen]
          position = Vector.new(2, 0)

          threatens = queen.threatens?(board, position)

          expect(threatens).to eql(true)
        end
      end

      context 'when given a square it can not move to' do
        it 'does not threaten that square' do
          queen = described_class.new(:white, 0, 0)
          board = Board.new [queen]
          position = Vector.new(2, 1)

          threatens = queen.threatens?(board, position)

          expect(threatens).to eql(false)
        end
      end
    end

    describe '#move_to' do
      context 'when given a positive vertical move' do
        it 'moves to that square' do
          queen = described_class.new(:white, 3, 0)
          board = Board.new [queen]
          destination = Vector.new(3, 1)

          queen.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(queen)
        end
      end

      context 'when given a negative vertical move' do
        it 'moves to that square' do
          queen = described_class.new(:white, 3, 1)
          board = Board.new [queen]
          destination = Vector.new(3, 0)

          queen.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(queen)
        end
      end

      context 'when given a positive horizontal move' do
        it 'moves to that square' do
          queen = described_class.new(:white, 3, 0)
          board = Board.new [queen]
          destination = Vector.new(4, 0)

          queen.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(queen)
        end
      end

      context 'when given a negative horizontal move' do
        it 'moves to that square' do
          queen = described_class.new(:white, 3, 0)
          board = Board.new [queen]
          destination = Vector.new(2, 0)

          queen.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(queen)
        end
      end

      context 'when given an obstructed vertical move' do
        it 'does not move to that square' do
          queen = described_class.new(:white, 3, 0)
          pawn = Pawn.new(:white, 3, 1)
          board = Board.new [queen, pawn]
          destination = Vector.new(3, 2)

          queen.move_to(board, destination)

          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when given an invalid move' do
        it 'does not move to that square' do
          queen = described_class.new(:white, 3, 0)
          board = Board.new [queen]
          destination = Vector.new(4, 2)

          queen.move_to(board, destination)

          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when given a right->up diagonal move' do
        it 'moves to that square' do
          queen = described_class.new(:white, 3, 0)
          board = Board.new [queen]
          destination = Vector.new(4, 1)

          queen.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(queen)
        end
      end

      context 'when given a right->down diagonal move' do
        it 'moves to that square' do
          queen = described_class.new(:white, 3, 1)
          board = Board.new [queen]
          destination = Vector.new(4, 0)

          queen.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(queen)
        end
      end

      context 'when given a left->down diagonal move' do
        it 'moves to that square' do
          queen = described_class.new(:white, 3, 1)
          board = Board.new [queen]
          destination = Vector.new(2, 0)

          queen.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(queen)
        end
      end

      context 'when given a left->up diagonal move' do
        it 'moves to that square' do
          queen = described_class.new(:white, 3, 1)
          board = Board.new [queen]
          destination = Vector.new(2, 2)

          queen.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(queen)
        end
      end

      context 'when given an capturable move' do
        it 'captures that piece' do
          queen = described_class.new(:white, 3, 1)
          pawn = Pawn.new(:black, 2, 2)
          board = Board.new [queen, pawn]
          destination = Vector.new(2, 2)

          queen.move_to(board, destination)

          expect(board.pieces).not_to include(pawn)
          expect(board.piece_at(destination)).to eql(queen)
        end
      end

      context 'when capturing on same team' do
        it 'does not capture that piece' do
          queen = described_class.new(:white, 3, 1)
          pawn = Pawn.new(:white, 2, 2)
          board = Board.new [queen, pawn]
          destination = Vector.new(2, 2)

          queen.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(pawn)
          expect(board.piece_at(Vector.new(3, 1))).to eql(queen)
        end
      end
    end
  end
end
