# frozen_string_literal: true

module Chess
  RSpec.describe Bishop do
    context 'when given an upwards diagonal move' do
      it 'performs that move' do
        bishop = described_class.new(:white, 0, 2)
        board = Board.new [bishop]
        destination = Vector.new(1, 3)

        bishop.move_to(board, destination)

        expect(board.piece_at(destination)).to eql(bishop)
      end
    end

    context 'when given an obscured diagonal move' do
      it 'does not perform that move' do
        bishop = described_class.new(:white, 2, 0)
        pawn = Pawn.new(:black, 3, 1)
        board = Board.new [bishop, pawn]
        destination = Vector.new(4, 2)

        bishop.move_to(board, destination)

        expect(board.piece_at(destination)).to be_nil
      end
    end

    context 'when given a capturable move' do
      it 'captures that piece' do
        bishop = described_class.new(:white, 2, 0)
        pawn = Pawn.new(:black, 3, 1)
        board = Board.new [bishop, pawn]
        destination = Vector.new(3, 1)

        bishop.move_to(board, destination)

        expect(board.pieces).not_to include(pawn)
        expect(board.piece_at(destination)).to eql(bishop)
      end
    end

    context 'when capturing a piece on same team' do
      it 'does not capture that piece' do
        bishop = described_class.new(:white, 2, 0)
        pawn = Pawn.new(:white, 3, 1)
        board = Board.new [bishop, pawn]
        destination = Vector.new(3, 1)

        bishop.move_to(board, destination)

        expect(board.piece_at(destination)).to eql(pawn)
        expect(board.piece_at(Vector.new(2, 0))).to eql(bishop)
      end
    end

    context 'when given a straight move' do
      it 'does not perform that move' do
        bishop = described_class.new(:white, 0, 2)
        board = Board.new [bishop]
        destination = Vector.new(0, 3)

        bishop.move_to(board, destination)

        expect(board.piece_at(destination)).to be_nil
      end
    end

    context 'when given a down right diagonal move' do
      it 'performs that move' do
        bishop = described_class.new(:white, 1, 3)
        board = Board.new [bishop]
        destination = Vector.new(2, 2)

        bishop.move_to(board, destination)

        expect(board.piece_at(destination)).to eql(bishop)
      end
    end
  end
end
