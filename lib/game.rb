require_relative "symbols.rb"
require_relative "board.rb"
require_relative "player.rb"
require "pry-byebug"

class ConnectFour
  include Symbols
  attr_accessor :p1, :p2, :current_player, :board

  def initialize
    @board = Board.new
  end

  def setup 
    @board.display_board
    @p1 = create_player(red_circle, 1)
    @p2 = create_player(yellow_circle, 2)
    @current_player = p1
  end 

  def create_player(piece, num)
    Player.new(piece, num)
  end

  def legal_move?(move)
    move.is_a?(Integer) && move.between?(1, 7) && @board.grid[0][move - 1] == empty_circle
  end

  def ask_move
    loop do
      move = gets.chomp.to_i
      return move if legal_move?(move)

      puts "Pick Again between 1 and 7"
    end
  end

  def play_round
    prompt
    move = ask_move
    @board.place_piece(move, current_player.piece)
    @board.display_board
  end

  def prompt
    puts "\n#{current_player} pick a column"
  end


end