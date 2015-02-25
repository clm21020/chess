class Pawn < Piece
  def initialize(color, pos, board)
    super
    @picture = color == "black" ? "♟" : "♙"
  end
end
