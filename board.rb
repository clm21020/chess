require_relative 'sliding_piece.rb'
require_relative 'stepping_piece.rb'
require_relative 'pawn.rb'

class Board
  SIZE ||= 8
  NON_PAWNS ||= [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

  def initialize(all_nils = false)
    @grid = Array.new(SIZE) { Array.new(SIZE) }
    place_pieces unless all_nils
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

  def find_team(color)
    @grid.flatten.compact.select do |piece|
      piece.color == color
    end
  end

  def move(start_pos, end_pos)
    piece = piece_at(start_pos)

    no_piece_error = ArgumentError.new("You don't have a piece there")
    invalid_move_error = ArgumentError.new("You can't move there!")

    raise no_piece_error if piece.nil?
    raise invalid_move_error unless piece.moves.include?(end_pos)

    self[start_pos[0], start_pos[1]] = nil
    self[end_pos[0], end_pos[1]] = piece
    piece.pos = end_pos
  end

  def deep_dup
    new_board = Board.new(true)
    all_pieces = find_team("white") + find_team("black")
    all_pieces.each do |piece|
      x = piece.pos[0]
      y = piece.pos[1]
      new_board[x,y] = piece.class.new(piece.color, piece.pos, new_board)
    end

    new_board
  end

  def piece_at(pos)
    self[pos[0], pos[1]]
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
    piece = piece_at(pos)
    piece.nil? ? nil : piece.color
  end

  def inspect
    "I am a board"
  end
end
