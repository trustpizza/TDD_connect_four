require_relative "symbols.rb"
require_relative "board.rb"
require_relative "player.rb"

class ConnectFour
  include Symbols
  attr_accessor :p1, :p2

  def initialize
    @board = Board.new
  end

  def setup 
    @p1 = create_player(red_circle, 1)
    @p2 = create_player(yellow_circle, 2)
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

end

ConnectFour.new