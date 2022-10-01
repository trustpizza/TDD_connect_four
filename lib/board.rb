require_relative "symbols.rb"
require "pry-byebug"

class Board
    attr_accessor :grid

    include Symbols

    def initialize
        @grid = Array.new(6) { Array.new(7, empty_circle) }
    end

    def place_piece(column, piece)
        column -= 1 #This is because arrays count starting from 0
        row = find_row(column)
        @grid[row][column] = piece
    end

    def find_row(row = 5, column)
        return row if grid[row][column] != red_circle && grid[row][column] != yellow_circle
        return if row < 0

        find_row(row - 1, column)
    end

    def display_board
        @grid.each do |row|
            puts row.join(' ')
        end
        puts (1..7).to_a.join(' ')
    end

    def game_over(piece)
        return true if is_full?
        false
    end

    def is_full?
        @grid.any? do |row|
            row.all? do |spot| 
                spot == red_circle || spot == yellow_circle
            end
        end
    end
end

game = Board.new
game.display_board