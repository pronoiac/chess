class HumanPlayer
  def initialize(color)
    @color = color
  end
  
  def play_turn(color)
    begin
      puts "#{color}, it's your turn!"
      puts "Enter (x, y) to (x, y) as 'x y x y'"
      print " > "
      input = gets.chomp
      # parse - TODO
      old_x, old_y, new_x, new_y = input.split(" ")
      # to return: [x, y], [x, y]
      return [[old_x.to_i, old_y.to_i], [new_x.to_i, new_y.to_i]]
    rescue
      retry
    end
  end
end

# def testing
#   h = HumanPlayer.new
#   p h.play_turn(:white)
# end
#
# testing