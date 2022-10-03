# frozen_string_literal: true

require_relative 'symbols'

class Board
  attr_accessor :grid

  include Symbols

  def initialize
    @grid = Array.new(6) { Array.new(7, empty_circle) }
  end

  def place_piece(column, piece)
    column -= 1 # This is because arrays count starting from 0
    row = find_row(column)
    @grid[row][column] = piece
  end

  def find_row(row = 5, column)
    return row if grid[row][column] != red_circle && grid[row][column] != yellow_circle
    return if row.negative?

    find_row(row - 1, column)
  end

  def display_board
    @grid.each do |row|
      puts row.join(' ')
    end
    puts (1..7).to_a.join(' ')
  end

  def game_over(piece)
    is_full? || game_won?(piece)
  end

  def is_full?
    grid.all? do |row|
      row.all? { |slot| slot == red_circle || slot == yellow_circle }
    end
  end

  def game_won?(piece)
    horizontal_win?(piece) || vertical_win?(piece) || diagonal_win?(piece)
  end

  def horizontal_win?(piece)
    @grid.each do |row|
      row.each_cons(4) do |four_spots|
        return true if four_spots.all?(piece)
      end
    end
    false
  end

  def vertical_win?(piece, column = 0, rows = [0, 1, 2, 3])
    return false if column == 7
    return true if rows.all? { |row| grid[row][column] == piece }

    rows.map! { |row| row += 1 }

    if rows == [3, 4, 5, 6]
      vertical_win?(piece, column + 1)
    else
      vertical_win?(piece, column, rows)
    end
  end

  def diagonal_win?(symbol)
    diagonals = create_diagonals

    diagonals.any? do |diagonal_set|
      diagonal_set.all? do |coords|
        grid[coords[0]][coords[1]] == symbol
      end
    end
  end

  def create_diagonals
    diagonals = []

    grid.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        diagonals << right_diagonal([[row_idx, col_idx]])
        diagonals << left_diagonal([[row_idx, col_idx]])
      end
    end

    diagonals.reject! { |diagonal| diagonal.length < 4 }
  end

  def right_diagonal(diagonal)
    3.times do
      unless diagonal[-1][0] == 5 || diagonal[-1][1] == 6
        diagonal << [diagonal[-1][0] + 1, diagonal[-1][1] + 1]
      end
    end

    diagonal
  end

  def left_diagonal(diagonal)
    3.times do
      unless diagonal[-1][0] == 5 || diagonal[-1][1] == 0
        diagonal << [diagonal[-1][0] + 1, diagonal[-1][1] - 1]
      end
    end

    diagonal
  end
end
