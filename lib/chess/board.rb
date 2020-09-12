# frozen_string_literal: true

require "chess/piece"

class Board
  HEIGHT = 8
  WIDTH = 8
  DEFAULT_PIECES = [
    'RNBQKBNR'.chars.map { |n| Chess::Piece.from_notation(n, :black) },
    WIDTH.times.map { Chess::Pawn.new(:black) },
    WIDTH.times.map { Chess::Blank.new },
    WIDTH.times.map { Chess::Blank.new },
    WIDTH.times.map { Chess::Blank.new },
    WIDTH.times.map { Chess::Blank.new },
    WIDTH.times.map { Chess::Pawn.new(:white) },
    'RNBQKBNR'.chars.map { |n| Chess::Piece.from_notation(n, :white) },
  ]

  attr_reader :pieces

  def initialize(pieces = DEFAULT_PIECES)
    @pieces = pieces
  end

  def to_s
    horizontal_heading +
    horizontal_padding +
    playfield_string +
    horizontal_padding +
    horizontal_heading
  end

  private

  def playfield_string
    pieces.each_with_index.map do |row, i|
      pieces_string = row.join('')
      "#{row_num(i)} #{pieces_string} #{row_num(i)}\n"
    end.join('')
  end

  def row_num(index)
    HEIGHT - index
  end

  def horizontal_heading
    "  abcdefgh  \n"
  end

  def horizontal_padding
    "            \n"
  end
end
