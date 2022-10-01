require_relative "../lib/board.rb"
require_relative "../lib/symbols"

describe Board do
    include Symbols

    subject(:board) {described_class.new}

    describe " #place_piece" do
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

            it "space above is still an empty_circle" do
                board.place_piece(1, red_circle)
                board.place_piece(1, yellow_circle)
                expect(board.grid[3][0]).to eql(empty_circle)
            end
        end
    end

    describe " #game_over" do
        context "When the board is NOT full" do 
            it "The game is NOT over" do 
                expect(board.game_over(red_circle)).to be false
                expect(board.game_over(yellow_circle)).to be false
            end
        end

        context "When the board is full" do 
            it "The game is over" do 
                board.grid = [
                    [red_circle, yellow_circle, red_circle, yellow_circle, red_circle, yellow_circle, red_circle],
                    [red_circle, yellow_circle, red_circle, yellow_circle, red_circle, yellow_circle, red_circle],
                    [red_circle, yellow_circle, red_circle, yellow_circle, red_circle, yellow_circle, red_circle],
                    [red_circle, yellow_circle, red_circle, yellow_circle, red_circle, yellow_circle, red_circle],
                    [red_circle, yellow_circle, red_circle, yellow_circle, red_circle, yellow_circle, red_circle],
                    [red_circle, yellow_circle, red_circle, yellow_circle, red_circle, yellow_circle, red_circle]
                ]

                expect(board.game_over(red_circle)).to be true
            end
        end
    end
end