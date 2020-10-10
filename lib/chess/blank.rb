# frozen_string_literal: true

module Chess
  class Blank
    def initialize(x, y)
      @x = x
      @y = y
    end

    def to_s
      [
        %w[□ ■],
        %w[■ □],
      ][@x % 2][@y % 2]
    end

    def self.notation
      ''
    end
  end
end
