class Pawn < SteppingPiece
  # TODO: Consider breaking into helper methods
  def moves
    moves_array = []    
    old_x, old_y = @position
    if @color == :black
      dx = +1
      home_row = 1
    else # white
      dx = -1
      home_row = 6
    end
      
    # moving straight forward
    new_x = old_x + dx
    square = @board[[new_x, old_y]]
    if square.nil?
      moves_array << [new_x, old_y] 
      if old_x == home_row   
        # check square 2. 
        new_x = new_x + dx
        square = @board[[new_x, old_y]]
        moves_array << [new_x, old_y] if square.nil?
      end
    end
    
    #check attacks
    new_x = old_x + dx
    [-1, +1].each do |dy|
      new_y = old_y + dy
      square = @board[[new_x, new_y]]
      next if square.nil? || square.color == self.color
      moves_array << [new_x, new_y]
    end
    
    moves_array
  end
end # /Pawns