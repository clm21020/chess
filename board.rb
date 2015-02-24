require_relative 'sliding_piece.rb'
require_relative 'stepping_piece.rb'

class Board
  SIZE = 8

  def initialize
    @board = []
  end

  def on_board?(potential_pos)
    (0...SIZE).include?(potential_pos[0]) && (0...SIZE).include?(potential_pos[1])
  end

  def occupied?(potential_pos)

  end
end
