require_relative 'piece'
require_relative 'cursor'
require_relative 'display'
require 'byebug'

class Board
    attr_reader :grid
    def initialize
        @grid = self.new_grid
        @display = Display.new(self)
    end

    def inspect
    end

    def new_grid
        @null_piece = NullPiece.instance
        board = Array.new(8) { Array.new(8) { @null_piece }}
    
        board.each_with_index do |el, row|
            next unless [0,1,6,7].include?(row)
            8.times do |col|
                color = row < 4 ? "white" : "black"
                board[row][col] = Piece.new([row,col], color)
            end
        end
    end

    def move_cursor
        count = 0
        begin
            until count > 20
                @display.move_cursor
                count += 1
            end
        rescue OutOfBoundsError
            retry
        end
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def []=(pos, placed_piece)
        row, col = pos
        @grid[row][col] = placed_piece
    end

    def move_piece(start_pos, end_pos)
        start, final = self[start_pos], self[end_pos]
        if valid_move?(start_pos, end_pos)
            self[end_pos] = start
            self[start_pos] = @null_piece
            self[end_pos].pos = end_pos
            "#{self[end_pos].class} was moved from #{start_pos} to #{end_pos}"
        end
        Display.new(self).render
    end

    def valid_move?(start_pos, end_pos)
        raise OutOfBoundsError if start_pos[0] < 0 || start_pos[1] > 7 
        raise OutOfBoundsError if end_pos[0] < 0 || end_pos[1] > 7
        start, final = self[start_pos], self[end_pos]
        raise NullPieceError if start.is_a?(NullPiece)
        raise SameColorError if start.color == final.color
        return true if final.is_a?(NullPiece)
        true
    end
end

class OutOfBoundsError < StandardError; end
class SameColorError < StandardError; end
class NullPieceError < StandardError; end