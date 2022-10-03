require_relative "symbols.rb"
require_relative "board.rb"
require_relative "player.rb"

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

  def play_game
    setup
    
    until @board.game_over(current_player.piece)
      @current_player = switch_player
      play_round
    end

    conclusion
  end

  def switch_player
    current_player == p1 ? p2 : p1
  end

  def conclusion
    puts "PLayer #{current_player.number} Won!" if @board.game_won?(current_player.piece)
    puts "Its a tie" if @board.is_full?
  end

  def play_round
    prompt
    move = ask_move
    @board.place_piece(move, current_player.piece)
    @board.display_board
  end

  def prompt
    puts "\nPlayer #{current_player.number} pick a column"
  end
end

game = ConnectFour.new
game.play_game