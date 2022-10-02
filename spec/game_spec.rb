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

      it "does not receive error message" do
        error_message = "Pick Again between 1 and 7"
        expect(game).not_to receive(:puts).with(error_message)
        game.ask_move
      end
    end
  end
end