# frozen_string_literal: true

require "chess/piece"
require "ostruct"

module Chess
  class Board
    HEIGHT = 8
    WIDTH = 8

    attr_reader :pieces
    attr_reader :moves

    def initialize(pieces = [
      *'RNBQKBNR'.chars.each_with_index.map { |n, x| Piece.from_notation(n, :black, x, 7) },
      *WIDTH.times.each_with_index.map { |x| Pawn.new(:black, x, 6) },
      *WIDTH.times.each_with_index.map { |x| Pawn.new(:white, x, 1) },
      *'RNBQKBNR'.chars.each_with_index.map { |n, x| Piece.from_notation(n, :white, x, 0) },
    ])
      @pieces = pieces
      @moves = []
    end

    def to_s
      horizontal_heading +
      horizontal_padding +
      playfield_string +
      horizontal_padding +
      horizontal_heading
    end

    def move(from, to)
      piece = piece_at(from)
      piece.move_to(self, to)
    end

    def piece_at(position)
      pieces.find { |piece| piece.x == position.x && piece.y === position.y }
    end

    def remove_piece(position)
      @pieces.reject! { |piece| piece.x == position.x && piece.y == position.y }
    end

    def add_piece(piece)
      @pieces << piece
    end

    private

    def playfield_string
      HEIGHT.times.reverse_each.map do |y|
        pieces_string = WIDTH.times.map do |x|
          piece = piece_at(OpenStruct.new(x: x, y: y)) || Chess::Blank.new(x, y)
        end.join('')

        "#{row_num(y)} #{pieces_string} #{row_num(y)}\n"
      end.join('')
    end

    def row_num(index)
      index + 1
    end

    def horizontal_heading
      "  abcdefgh  \n"
    end

    def horizontal_padding
      "            \n"
    end
  end
end
