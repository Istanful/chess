# frozen_string_literal: true

module Chess
  class Path
    attr_reader :from
    attr_reader :to

    def initialize(from, to)
      @from = from
      @to = to
    end

    def include?(point)
      return point.x == to.x && in_vertical_range?(point) if vertical?
      return point.y == to.y && in_horizontal_range?(point) if horizontal?

      y_at(point.x)  == point.y && in_range?(point)
    end

    def vertical?
      slope.zero? && delta.y.abs.positive?
    end

    def horizontal?
      slope.zero? && delta.x.abs.positive?
    end

    def plot
      return plot_vertical if vertical?

      plot_diagonal
    end

    private

    def plot_diagonal
      min, max = [from, to].sort_by { |point| point.x }
      x_values = ((max - min).x + 1).times
      x_values.map { |i| Vector.new(min.x + i, y_at(min.x + i)) }
    end

    def plot_vertical
      min, max = [from, to].sort_by { |point| point.y }
      y_values = ((max - min).y + 1).times
      y_values.map { |i| Vector.new(min.x, min.y + i) }
    end

    def y_at(x)
      slope * x + intercept
    end

    def in_horizontal_range?(point)
      point.x > [from.x, to.x].min && point.x < [from.x, to.x].max
    end

    def in_vertical_range?(point)
      point.y > [from.y, to.y].min && point.y < [from.y, to.y].max
    end

    def in_range?(point)
      in_horizontal_range?(point) && in_vertical_range?(point)
    end

    def slope
      (to.y - from.y) / (to.x - from.x)
    rescue
      0
    end

    def delta
      to - from
    end

    def intercept
      to.y - slope * to.x
    end
  end
end
