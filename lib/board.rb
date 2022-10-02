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
        #binding.pry
        is_full? || game_won?(piece)
    end

    def is_full?
        @grid.all? do |row|
            row.all? { |slot| slot == red_circle || slot == yellow_circle }
        end
    end

    def game_won?(piece)
        horizontal = horizontal_win?(piece)
    end

    def horizontal_win?(piece)
        grid.any? do |row|
            row.each_cons(4) {|four_spots| return true if four_spots.all?(piece)}
        end
        false
    end
end

board = Board.new
board.game_won?("\e[0;31;49m●\e[0m")