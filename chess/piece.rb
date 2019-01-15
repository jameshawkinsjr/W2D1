require 'singleton'

class Piece
    attr_reader :color
    attr_accessor :pos

    def initialize(pos, color)
        @color = color
        @pos = pos
    end

end

class NullPiece < Piece
    include Singleton

    def initialize
    end
end