require_relative 'sliding_piece.rb'
require_relative 'stepping_piece.rb'
require_relative 'pawn.rb'

class Board
  SIZE ||= 8
  NON_PAWNS ||= [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

  def initialize
    @grid = Array.new(SIZE) { Array.new(SIZE) }
    place_pieces
  end

  def place_pieces
    place_non_pawns("black")
    place_non_pawns("white")
    # place_pawns("black")
    # place_pawns("white")
  end

  def place_non_pawns(color)
    x = color == "black" ? 0 : (SIZE - 1)

    NON_PAWNS.each_with_index do |val, idx|
      self[x, idx] = val.new(color, [x, idx], self)
    end
  end

  def place_pawns(color)
    x = color == "black" ? 1 : (SIZE - 2)
    (0...SIZE).each do |i|
      self[x, i] = Pawn.new(color, [x, i], self)
    end

  end

  def in_check?(color)
    # returns whether a player is in check.
    # You can implement this by (1) finding the position of the king on the board then
    # (2) seeing if any of the opposing pieces can move to that position.
    (0...SIZE)

  end

  def move(start_pos, end_pos)
    # This should update the 2d grid and also the moved piece's position.
    # You'll want to raise an exception if: (a) there is no piece at start or
    # (b) the piece cannot move to end_pos.
  end

  def [](x, y)
    @grid[x][y]
  end

  def []=(x, y, piece)
    @grid[x][y] = piece
  end

  def on_board?(potential_pos)
    (0...SIZE).include?(potential_pos[0]) && (0...SIZE).include?(potential_pos[1])
  end

  def occupied?(potential_pos)
    @grid
  end

  def color_of_piece_at(pos)
    piece = @grid[pos[0]][pos[1]]
    piece.nil? ? nil : piece.color
  end
end
