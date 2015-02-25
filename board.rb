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

    # self[2, 4] = Rook.new("black", [2, 4], self)
    # self[6, 4] = Rook.new("white", [6, 4], self)
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
    king = find_king(color)
    other_color = (color == "black" ? "white" : "black")
    find_team(other_color).each do |piece|
      piece.moves.each do |pos|
        return true if pos == king.pos
      end
    end

    false
  end

  def find_king(color)
    @grid.flatten.compact.find do |piece|
      piece.class == King && piece.color == color
    end
  end

  def move(start_pos, end_pos)
    # This should update the 2d grid and also the moved piece's position.
    # You'll want to raise an exception if: (a) there is no piece at start or
    # (b) the piece cannot move to end_pos.
  end

  def find_team(color)
    @grid.flatten.compact.select do |piece|
      piece.color == color
    end
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

  def inspect
    "I am a board"
  end
end
