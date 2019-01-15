require_relative 'piece'
require 'byebug'
class Board

    def initialize
        @grid = self.new_grid
    end

    def new_grid
        @null_piece = NullPiece.instance
        board = []
        8.times { board << [] }

        board.each_with_index do |el, row|
            next if [0,1,6,7].include?(row)
            8.times do |col|
                board[row] << @null_piece
            end
        end
        board.each_with_index do |el, row|
            next unless [0,1,6,7].include?(row)
            8.times do |col|
                color = row < 4 ? "white" : "black"
                board[row] << Piece.new([row,col], color)
            end
        end
    end

    def [](pos)
        row,col = pos
        @grid[row][col]
    end

    def []=(pos, move)
        row,col = pos
        @grid[row][col] = move
    end

    def move_piece(start_pos, end_pos)
        debugger
        raise StandardError if @grid[start_pos].is_a?(NullPiece)
        # raise StandardError unless valid_move?
        @grid[start_pos], @grid[end_pos] = start, final
        if start.color != final.color
            final = start
            start = @null_piece
        else
            start, final = final, start
        end
    end

    def valid_move?(start_pos, end_pos)
        # if the piece at start position can overtake
        #      the piece at end position return true
    end
end
