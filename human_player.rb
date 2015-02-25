class HumanPlayer
  def play_turn
    move = {}

    puts "Enter your start position: x y"
    move["start"] = gets.chomp.split.map(&:to_i)

    puts "Enter your end position: x y"
    move["end"] = gets.chomp.split.map(&:to_i)

    move
  end
end
