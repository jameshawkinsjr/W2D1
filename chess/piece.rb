require 'singleton'

class Piece
    attr_reader :color, :pos

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