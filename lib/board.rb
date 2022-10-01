require_relative "symbols.rb"

class Board
    attr_accessor :grid

    include Symbols

    def initialize
        @grid = Array.new(6) { Array.new(7, empty_circle) }
    end

    def place_piece(column, piece)
        column -= 1 #This is because arrays count starting from 0
        row = find_row(column)
        @grid[5][column] = piece
    end

    def find_row(column)
        row = 0
        until @grid[row + 1][column] == red_circle || yellow_circle || nil
            row += 1
        end
        row
    end

    def display_board
        @grid.each do |row|
            puts row.join(' ')
        end
        puts (1..7).to_a.join(' ')
    end
end

game = Board.new
game.display_board