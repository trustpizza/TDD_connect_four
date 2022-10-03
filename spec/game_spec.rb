require_relative "../lib/game.rb"
require_relative "../lib/symbols.rb"

describe ConnectFour do
  include Symbols
  subject(:game) { described_class.new }

  describe "#create_player" do
    it "creates player 1 with a token" do
      game.setup
      expect(game.p1.piece).to be(red_circle)
    end

    it "creates player 2 with a token" do
      game.setup
      expect(game.p2.piece).to be(yellow_circle)
    end
  end

  describe "#legal_move?" do
    it "does NOT allow for moves outside of the gamegrid" do 
      expect(game.legal_move?(8)).to be(false)
    end
  end

  describe "#ask_move" do 

    context "When move is valid" do 
      before do
        allow(game).to receive(:gets).and_return('1\n')
      end

      it "does not receives error message" do
        error_message = "Pick Again between 1 and 7"
        expect(game).not_to receive(:puts).with(error_message)
        game.ask_move
      end
    end

    context 'when given an invalid move, then a valid move' do
      before do 
        letter = 'z'
        valid_move = '5'
        allow(game).to receive(:gets).and_return(letter, valid_move)
      end
      
      it 'Returns one error message, then returns' do
        error_message = "Pick Again between 1 and 7"
        expect(game).to receive(:puts).with(error_message).once
        game.ask_move
      end
    end
  end

  describe "#play_round" do
    before do 
      game.setup
      allow(game).to receive(:prompt)
      allow(game).to receive(:current_player).and_return(game.p1)
      allow(game).to receive(:ask_move).and_return(3)
    end

    it 'sends #place_piece to the board' do
      allow(game.board).to receive(:display_board)
      expect(game.board).to receive(:place_piece).with(3, game.current_player.piece)
      game.play_round
    end
  end

  describe "#switch_player" do 
    before do 
      game.setup
      game.current_player = game.switch_player
    end

    it 'Current player is P2' do
      expect(game.current_player).to be(game.p2)
    end
  end

  describe "#board.game_over" do
    context "False Test Cases" do
      before do
        game.setup
      end


      it 'Game is not over when you start' do
        expect(game.board.game_over(game.current_player.piece)).to be(false)
      end
    end

    context "True Test Cases" do
      before do
        game.setup
        game.board.grid = [
            [empty_circle, empty_circle, empty_circle, empty_circle, empty_circle,
             empty_circle, empty_circle],
            [empty_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle,
             empty_circle],
            [empty_circle, empty_circle, empty_circle, empty_circle, empty_circle,
             empty_circle, red_circle],
            [red_circle, red_circle, empty_circle, empty_circle, empty_circle,
             empty_circle, red_circle],
            [red_circle, red_circle, empty_circle, empty_circle, empty_circle,
             empty_circle, red_circle],
            [red_circle, red_circle, empty_circle, empty_circle, empty_circle,
             empty_circle, red_circle]
          ]

      end

      it '#game_win? method fires' do
        expect(game.board.game_won?(game.current_player.piece)).to be(true)
      end

      it "game_over method fires" do
        expect(game.board.game_over(game.current_player.piece)).to be(true)
      end 
    end
  end
end