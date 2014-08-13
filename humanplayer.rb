require "debugger"

class HumanPlayer
  def initialize(color)
    @color = color
  end
  
  def play_turn(color)
    begin
      puts "#{color}, it's your turn!"
      puts "a8 h1 is equivalent to [0, 0], [7, 7]"
      input = gets.chomp
      # parse - TODO
      from, to = input.split(' ')
      [human_to_computer(from), human_to_computer(to)]
    rescue
      retry
    end
  end
  
  def human_to_computer(string)
    human_cols = %w{a b c d e f g h}
    human_rows = [8, 7, 6, 5, 4, 3, 2, 1]
    
    human_col, human_row = string.split("")

    computer_row = human_rows[human_row.to_i]
    computer_col = human_cols.index(human_col)
    [computer_row, computer_col]
  end
end

def testing
  h = HumanPlayer.new(:white)
  # p h.play_turn(:white)
  
  p h.human_to_computer("a6")
end