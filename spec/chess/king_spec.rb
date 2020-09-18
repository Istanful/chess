# frozen_string_literal: true

module Chess
  RSpec.describe King do
    it_behaves_like 'a piece'

    describe '#threatens?' do
      context 'when given a square next to king' do
        it 'is considered to threaten that square' do
          king = described_class.new(:white, 0, 0)
          board = Board.new [king]
          point = Vector.new(1, 0)

          threatens = king.threatens?(board, point)

          expect(threatens).to eql(true)
        end
      end

      context 'when given a square too far away' do
        it 'is not threatening that square' do
          king = described_class.new(:white, 0, 0)
          board = Board.new [king]
          point = Vector.new(2, 0)

          threatens = king.threatens?(board, point)

          expect(threatens).not_to eql(true)
        end
      end
    end

    describe '#move_to' do
      context 'when given an occupied square' do
        it 'does not move to that square' do
          king = described_class.new(:white, 0, 2)
          pawn = Pawn.new(:white, 0, 1)
          board = Board.new [king, pawn]
          destination = Vector.new(0, 1)

          king.move_to(board, destination)

          expect(board.piece_at(Vector.new(0, 2))).to eql(king)
          expect(board.piece_at(destination)).to eql(pawn)
        end
      end

      context 'when given a valid up->right move' do
        it 'moves to that square' do
          king = described_class.new(:white, 0, 2)
          board = Board.new [king]
          destination = Vector.new(1, 3)

          king.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(king)
        end
      end

      context 'when given a 2 step move' do
        it 'does not move to that square' do
          king = described_class.new(:white, 0, 2)
          board = Board.new [king]
          destination = Vector.new(2, 4)

          king.move_to(board, destination)

          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when given a negative 2 step move' do
        it 'does not move to that square' do
          king = described_class.new(:white, 2, 2)
          board = Board.new [king]
          destination = Vector.new(0, 0)

          king.move_to(board, destination)

          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when given a 2 step horizontal move' do
        it 'does not move to that square' do
          king = described_class.new(:white, 0, 0)
          board = Board.new [king]
          destination = Vector.new(2, 0)

          king.move_to(board, destination)

          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when given a capturable move' do
        it 'captures that piece' do
          king = described_class.new(:white, 2, 2)
          pawn = Pawn.new(:black, 2, 1)
          board = Board.new [king, pawn]
          destination = Vector.new(2, 1)

          king.move_to(board, destination)

          expect(board.pieces).not_to include(pawn)
          expect(board.piece_at(destination)).to eql(king)
        end
      end

      context 'when performing a short castling' do
        it 'moves both the king and castle' do
          king = described_class.new(:white, 4, 0)
          rook = Rook.new(:white, 7, 0)
          board = Board.new [king, rook]
          destination = Vector.new(6, 0)

          king.move_to(board, destination)

          expect(board.piece_at(Vector.new(5, 0))).to eql(rook)
          expect(board.piece_at(destination)).to eql(king)
        end
      end

      context 'when performing a short castling after king has moved' do
        it 'does not perform the castling' do
          king = described_class.new(:white, 3, 0)
          rook = Rook.new(:white, 7, 0)
          board = Board.new [king, rook]
          destination = Vector.new(6, 0)

          king.move_to(board, Vector.new(4, 0))
          king.move_to(board, destination)

          expect(board.piece_at(Vector.new(4, 0))).to eql(king)
          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when performing a short castling after the rook has moved' do
        it 'does not perform the castling' do
          king = described_class.new(:white, 4, 0)
          rook = Rook.new(:white, 6, 0)
          board = Board.new [king, rook]
          destination = Vector.new(6, 0)

          rook.move_to(board, Vector.new(7, 0))
          king.move_to(board, destination)

          expect(board.piece_at(Vector.new(4, 0))).to eql(king)
          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when performing a short castling against a bishop' do
        it 'does not perform the castling' do
          king = described_class.new(:white, 4, 0)
          bishop = Bishop.new(:white, 7, 0)
          board = Board.new [king, bishop]
          destination = Vector.new(6, 0)

          king.move_to(board, destination)

          expect(board.piece_at(Vector.new(4, 0))).to eql(king)
          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when performing a short castling against an opposing rook' do
        it 'does not perform the castling' do
          king = described_class.new(:white, 4, 0)
          rook = Rook.new(:black, 7, 0)
          board = Board.new [king, rook]
          destination = Vector.new(6, 0)

          king.move_to(board, destination)

          expect(board.piece_at(Vector.new(4, 0))).to eql(king)
          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when performing a short castling with pieces in between' do
        it 'does not perform the castling' do
          king = described_class.new(:white, 4, 0)
          pawn = Pawn.new(:white, 5, 0)
          rook = Rook.new(:white, 7, 0)
          board = Board.new [king, rook, pawn]
          destination = Vector.new(6, 0)

          king.move_to(board, destination)

          expect(board.piece_at(Vector.new(4, 0))).to eql(king)
          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when performing a short castling with too many steps' do
        it 'does not perform the castling' do
          king = described_class.new(:white, 4, 0)
          rook = Rook.new(:white, 7, 0)
          board = Board.new [king, rook]
          destination = Vector.new(7, 0)

          king.move_to(board, destination)

          expect(board.piece_at(Vector.new(4, 0))).to eql(king)
        end
      end

      context 'when performing a long castling' do
        it 'performs the castling' do
          king = described_class.new(:white, 4, 0)
          rook = Rook.new(:white, 0, 0)
          board = Board.new [king, rook]
          destination = Vector.new(2, 0)

          king.move_to(board, destination)

          expect(board.piece_at(Vector.new(3, 0))).to eql(rook)
          expect(board.piece_at(destination)).to eql(king)
        end
      end

      context 'when a long castling would pass an attacked square' do
        it 'does not perform the castling' do
          king = described_class.new(:white, 4, 0)
          opposing_rook = Rook.new(:black, 3, 1)
          rook = Rook.new(:white, 0, 0)
          board = Board.new [king, rook, opposing_rook]
          destination = Vector.new(2, 0)

          king.move_to(board, destination)

          expect(board.piece_at(Vector.new(0, 0))).to eql(rook)
          expect(board.piece_at(destination)).to be_nil
        end
      end

      context 'when a long castling would land on an attacked square' do
        it 'does not perform the castling' do
          king = described_class.new(:white, 4, 0)
          opposing_rook = Rook.new(:black, 2, 1)
          rook = Rook.new(:white, 0, 0)
          board = Board.new [king, rook, opposing_rook]
          destination = Vector.new(2, 0)

          king.move_to(board, destination)

          expect(board.piece_at(Vector.new(0, 0))).to eql(rook)
          expect(board.piece_at(destination)).to be_nil
        end
      end
    end
  end
end
