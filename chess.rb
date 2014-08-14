require 'debugger'
require_relative 'board'
require_relative 'piece'
require_relative 'sliding_piece'
require_relative 'stepping_piece'
require_relative 'pawn'
require_relative 'pieces'
require_relative 'testing'
require_relative 'humanplayer'

class Game
  attr_reader :board
  def initialize
    @user1 = HumanPlayer.new(:white)
    @user2 = HumanPlayer.new(:black)
    @board = Board.new
  end
  
  def run
    color = :white
    while true # @board.checkmate?(:black) || @board.checkmate?(:white)       
      begin
        @board.display_board
            
        input = @user1.play_turn(color)
        @board.move(input[0], input[1], color)
        color = @board.opponent_color(color)
        if @board.in_check?(color)
          puts "post: #{color} in check!"
          if @board.checkmate?(color)
            puts "And mate!"
            break
          end
        end        
      rescue ArgumentError => myError
        puts myError.message
        retry
      end
    end
    puts "#{color} loses!" 
  end
end



game = Game.new()
game.run