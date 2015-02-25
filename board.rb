require_relative 'sliding_piece.rb'
require_relative 'stepping_piece.rb'
require_relative 'pawn.rb'

class Board
  SIZE ||= 8

  def initialize
    @board = Array.new(SIZE) { Array.new(SIZE) }
    place_pieces
  end

  def place_pieces
    place_non_pawns("black")
    place_non_pawns("white")
    place_pawns("black")
    place_pawns("white")
  end

  def place_non_pawns(color)
    x = color == "black" ? 0 : (SIZE - 1)

    (0...SIZE).each do |i|
      case i
      when 0 || 7
        self[x, i] = Rook.new(color, [x, i], self)
      when 1 || 6
        self[x, i] = Knight.new(color, [x, i], self)
      when 2 || 5
        self[x, i] = Bishop.new(color, [x, i], self)
      when 3
        self[x, i] = Queen.new(color, [x, i], self)
      when 4
        self[x, i] = King.new(color, [x, i], self)
      end
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

  end

  def move(start_pos, end_pos)
    # This should update the 2d grid and also the moved piece's position.
    # You'll want to raise an exception if: (a) there is no piece at start or
    # (b) the piece cannot move to end_pos.
  end

  def [](x, y)
    @board[x][y]
  end

  def []=(x, y, piece)
    @board[x][y] = piece
  end

  def on_board?(potential_pos)
    (0...SIZE).include?(potential_pos[0]) && (0...SIZE).include?(potential_pos[1])
  end

  def occupied?(potential_pos)
    @board
  end

  def color_of_piece_at(pos)
    piece = @board[pos[0]][pos[1]]
    piece.nil? ? nil : piece.color
  end
end
