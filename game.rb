require_relative 'board.rb'
require_relative 'human_player.rb'

class Game
  def initialize
    @board = Board.new
    @white = HumanPlayer.new("white")
    @black = HumanPlayer.new("black")
    @current_player = @white
  end

  def play
    until @board.checkmate?(@current_player.color)
      begin
        move = @current_player.play_turn
        @board.move(move["start"], move["end"])
      rescue ArgumentError => e
        puts "Try again. #{e.message}"
        retry
      end

      @current_player = @current_player == @white ? @black : @white
    end

    puts "#{@current_player.color} lost!"



    # alternates between players
    # prompting them to move/continuously calls play_turn
    # handle exceptions from Board#move and report them.
  end
end

puts "♔"
