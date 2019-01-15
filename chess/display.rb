require 'colorize' #just in display.rb
require_relative 'cursor'
require 'byebug'

class Display
    attr_reader :board
    def initialize(board)
        @board = board
        @cursor = Cursor.new([7,0], board)
    end
    #change color of cursor when piece selected (return, space)
    def move_cursor
        render
        print "Where would you like to move the cursor?"
        @cursor.get_input
        # end_pos = @cursor.get_input
        # move_piece(start_pos, end_pos) # => whatever key you "select"
        # => Choose where you want to move the piece you selected
    end

    def render
        system("clear")
        puts "   A  B  C  D  E  F  G  H "
        @board.grid.each_with_index do |row, row_idx|
            print "#{8-row_idx} "
            row.each_with_index do |col, col_idx|
                if [row_idx, col_idx] == @cursor.cursor_pos #KNOWN ISSUE doesnt display piece underneath
                    print "   ".on_light_cyan
                elsif (row_idx + col_idx).even?
                    if col.is_a?(NullPiece)
                        print "   ".on_white
                    else
                        print " P ".on_white
                    end
                else
                    if col.is_a?(NullPiece)
                        print "   ".on_red
                    else
                        print " P ".on_red
                    end
                end
            end
            puts
        end
        return nil
    end
end

#will render @cursor_pos in different color


# puts "Test String".black
# puts "Test String".light_black
# puts "Test String".red
# puts "Test String".light_red
# puts "Test String".green
# puts "Test String".light_green
# puts "Test String".yellow
# puts "Test String".light_yellow
# puts "Test String".blue
# puts "Test String".light_blue
# puts "Test String".magenta
# puts "Test String".light_magenta
# puts "Test String".cyan
# puts "Test String".light_cyan
# puts "Test String".white
# puts "Test String".light_white
# puts "Test String".default