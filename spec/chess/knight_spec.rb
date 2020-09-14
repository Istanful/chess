# frozen_string_literal: true

module Chess
  RSpec.describe Knight do
    describe '#move_to' do
      context 'when given an up->right move' do
        it 'performs that move' do
          knight = described_class.new(:white, 1, 0)
          board = Board.new [knight]
          destination = Vector.new(2, 2)

          knight.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(knight)
        end
      end

      context 'when given an up->left move' do
        it 'performs that move' do
          knight = described_class.new(:white, 1, 0)
          board = Board.new [knight]
          destination = Vector.new(0, 2)

          knight.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(knight)
        end
      end

      context 'when given a down->right move' do
        it 'performs that move' do
          knight = described_class.new(:white, 5, 5)
          board = Board.new [knight]
          destination = Vector.new(6, 3)

          knight.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(knight)
        end
      end

      context 'when given an down->left move' do
        it 'performs that move' do
          knight = described_class.new(:white, 5, 5)
          board = Board.new [knight]
          destination = Vector.new(4, 3)

          knight.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(knight)
        end
      end

      context 'when given a right->up move' do
        it 'performs that move' do
          knight = described_class.new(:white, 5, 5)
          board = Board.new [knight]
          destination = Vector.new(7, 6)

          knight.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(knight)
        end
      end

      context 'when given a right->down move' do
        it 'performs that move' do
          knight = described_class.new(:white, 5, 5)
          board = Board.new [knight]
          destination = Vector.new(7, 4)

          knight.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(knight)
        end
      end

      context 'when given a left->up move' do
        it 'performs that move' do
          knight = described_class.new(:white, 5, 5)
          board = Board.new [knight]
          destination = Vector.new(3, 6)

          knight.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(knight)
        end
      end

      context 'when given a left->down move' do
        it 'performs that move' do
          knight = described_class.new(:white, 5, 5)
          board = Board.new [knight]
          destination = Vector.new(3, 4)

          knight.move_to(board, destination)

          expect(board.piece_at(destination)).to eql(knight)
        end
      end

      context 'when given a capturable move' do
        it 'captures that piece' do
          knight = described_class.new(:white, 5, 5)
          pawn = Pawn.new(:black, 3, 4)
          board = Board.new [knight, pawn]
          destination = Vector.new(3, 4)

          knight.move_to(board, destination)

          expect(board.pieces).not_to include(pawn)
          expect(board.piece_at(destination)).to eql(knight)
        end
      end

      context 'when capturing a piece on same team' do
        it 'does not capture that piece' do
          knight = described_class.new(:white, 5, 5)
          pawn = Pawn.new(:white, 3, 4)
          board = Board.new [knight, pawn]
          destination = Vector.new(3, 4)

          knight.move_to(board, destination)

          expect(board.pieces).to include(pawn)
          expect(board.piece_at(Vector.new(5, 5))).to eql(knight)
        end
      end

      context 'when given an illegal move' do
        it 'does not perform that move' do
          knight = described_class.new(:white, 1, 0)
          board = Board.new [knight]
          destination = Vector.new(1, 2)

          knight.move_to(board, destination)

          expect(board.piece_at(destination)).to be_nil
        end
      end
    end
  end
end
