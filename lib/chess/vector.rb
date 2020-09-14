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

    def hypotenuse
      Math.sqrt(x ** 2 + y ** 2)
    end

    def ==(vector)
      vector.x == x && vector.y == y
    end
  end
end
