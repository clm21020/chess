class Piece
  def initialize(color, pos, board)
    @color, @pos, @board = color, pos, board
  end

  def moves # should return an array of places a Piece can move to.
    raise "Not implemented"
  end
end
