# frozen_string_literal: true

module Chess
  class Move
    attr_reader :piece
    attr_reader :from
    attr_reader :to

    def initialize(piece, from, to)
      @piece = piece
      @from = from
      @to = to
    end

    def delta
      to - from
    end
  end
end
