# frozen_string_literal: true

module Chess
  class Vector
    attr_reader :x
    attr_reader :y

    def initialize(x, y)
      @x = x
      @y = y
    end

    def -(vector)
      Vector.new(x - vector.x, y - vector.y)
    end

    def +(vector)
      Vector.new(x + vector.x, y + vector.y)
    end
  end
end
