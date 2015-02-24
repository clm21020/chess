require_relative 'piece.rb'

class SteppingPiece < Piece
  def initialize(color, pos, board)
    super
  end

  # def moves # should return an array of places a Piece can move to.
  #   raise "Not implemented"
  # end
end

class Knight < SteppingPiece
  def initialize(color, pos, board)
    super
  end
end

class King < SteppingPiece
  def initialize(color, pos, board)
    super
  end
end
