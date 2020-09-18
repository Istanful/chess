# frozen_string_literal: true

module Chess
  RSpec.describe Rook do
    it_behaves_like 'a piece'

    describe '#threatens?' do
      context 'when the given point is in movable path' do
        it 'is considered to be threatening that square' do
          rook = described_class.new(:white, 0, 0)
          board = Board.new [rook]
          point = Vector.new(0, 1)

          threatens = rook.threatens?(board, point)

          expect(threatens).to eql(true)
        end
      end

      context 'when the given point is not in movable path' do
        it 'is considered to not be threatening that square' do
          rook = described_class.new(:white, 0, 0)
          board = Board.new [rook]
          point = Vector.new(1, 1)

          threatens = rook.threatens?(board, point)

          expect(threatens).to eql(false)
        end
      end
    end

    describe '#move_to' do
      context 'when given a capturable move' do
        it 'captures that piece' do
          rook = described_class.new(:white, 0, 0)
          pawn = Pawn.new(:black, 0, 1)
          board = Board.new [rook, pawn]
          destination = Vector.new(0, 1)

          rook.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(rook)
          expect(board.pieces).not_to include(pawn)
        end
      end

      context 'when given a move that would capture on same team' do
        it 'does not capture that piece' do
          rook = described_class.new(:white, 0, 0)
          pawn = Pawn.new(:white, 0, 1)
          board = Board.new [rook, pawn]
          destination = Vector.new(0, 1)

          rook.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(pawn)
        end
      end

      context 'when given a valid vertical move' do
        it 'moves to that position' do
          rook = described_class.new(:white, 0, 0)
          board = Board.new [rook]
          destination = Vector.new(0, 2)

          rook.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(rook)
        end
      end

      context 'when given a diagonal move' do
        it 'does not move to that position' do
          rook = described_class.new(:white, 0, 0)
          board = Board.new [rook]
          destination = Vector.new(1, 2)

          rook.move_to(board, destination)

          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when given an obstructed positive vertical move' do
        it 'does not move to that position' do
          rook = described_class.new(:white, 0, 0)
          pawn = Pawn.new(:white, 0, 1)
          board = Board.new [rook, pawn]
          destination = Vector.new(0, 2)

          rook.move_to(board, destination)

          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when given an obstructed negative vertical move' do
        it 'does not move to that position' do
          rook = described_class.new(:white, 0, 2)
          pawn = Pawn.new(:white, 0, 1)
          board = Board.new [rook, pawn]
          destination = Vector.new(0, 0)

          rook.move_to(board, destination)

          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when given an obstructed positive horizontal move' do
        it 'does not move to that position' do
          rook = described_class.new(:white, 0, 1)
          pawn = Pawn.new(:white, 1, 1)
          board = Board.new [rook, pawn]
          destination = Vector.new(2, 1)

          rook.move_to(board, destination)

          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when given an obstructed positive horizontal move' do
        it 'does not move to that position' do
          rook = described_class.new(:white, 0, 1)
          pawn = Pawn.new(:white, 1, 1)
          board = Board.new [rook, pawn]
          destination = Vector.new(2, 1)

          rook.move_to(board, destination)

          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when given an obstructed negative horizontal move' do
        it 'does not move to that position' do
          rook = described_class.new(:white, 2, 1)
          pawn = Pawn.new(:white, 1, 1)
          board = Board.new [rook, pawn]
          destination = Vector.new(0, 1)

          rook.move_to(board, destination)

          expect(board.piece_at(destination)).to be_nil
        end
      end
    end
  end
end
