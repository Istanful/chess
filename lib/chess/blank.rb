# frozen_string_literal: true

module Chess
  class Blank
    def initialize(*args)
    end

    def to_s
      ' '
    end

    def self.notation
      ''
    end
  end
end
