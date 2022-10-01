require_relative "../lib/board.rb"
require_relative "../lib/symbols"

describe Board do
    include Symbols

    subject(:board) {described_class.new}

    describe "#place_piece" do
        context "When column is empty" do 
            it "places a piece in the bottom slot" do 
                board.place_piece(1, red_circle)
                expect(board.grid[5][0]).to eql(red_circle)
            end

            it "does NOT place tokens elsewhere" do 
                board.place_piece(1, red_circle)
                expect(board.grid[4][0]).not_to eql(red_circle || yellow_circle)
            end
        end
        
        context "When column has one spot filled" do
            it "places a piece above the prior piece" do 
                board.place_piece(1, red_circle)
                board.place_piece(1, yellow_circle)
                expect(board.grid[4][0]).to eql(yellow_circle)
            end
        end
    end
end