class Player
    attr_accessor :number, :piece
    def initialize(piece, number)
        @number = number
        @piece = piece
    end
end