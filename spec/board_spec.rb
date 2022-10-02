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
            it "The game is NOT over with empty board" do 
                expect(board.horizontal_win?(red_circle)).to be false
            end
        end

        context "When the board is full" do 
            before do 
                board.instance_variable_set(:@grid, [
                    [red_circle, yellow_circle, red_circle, yellow_circle, red_circle, yellow_circle, red_circle],
                    [yellow_circle, red_circle, yellow_circle, red_circle, yellow_circle, red_circle, yellow_circle],
                    [yellow_circle, red_circle, yellow_circle, red_circle, yellow_circle, red_circle, yellow_circle],
                    [red_circle, yellow_circle, red_circle, yellow_circle, red_circle, yellow_circle, red_circle],
                    [red_circle, yellow_circle, red_circle, yellow_circle, red_circle, yellow_circle, red_circle],
                    [red_circle, yellow_circle, red_circle, yellow_circle, red_circle, yellow_circle, red_circle]
                ])
            end
            it "The game is over" do 
                expect(board.game_over(red_circle)).to be true
            end
        end

        context "Horizontal Win Testing" do 
            before do
                board.instance_variable_set(:@grid, [
                    [empty_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle],
                    [empty_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle],
                    [empty_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle],
                    [empty_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle],
                    [empty_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle],
                    [empty_circle, empty_circle, empty_circle, red_circle, red_circle, red_circle, red_circle]
                ])
            end

            it "expect that the game is over" do 
                expect(board.game_over(red_circle)).to be true
            end
        end

        context "Vertical Win Testing" do
            before do 
                board.instance_variable_set(:grid, [
                    [empty_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle],
                    [empty_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle],
                    [red_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle],
                    [red_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle],
                    [red_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle],
                    [red_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle, empty_circle]
                ])
                end
            end
    end
end

