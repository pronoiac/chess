class SteppingPiece < Piece
  KNIGHTS_DELTA = [
   [-1, -2], [-1, +2], [+1, -2], [+1, +2],
   [-2, -1], [-2, +1], [+2, -1], [+2, +1]
  ]

  def moves
    #calls #move_dirs on current piece
    moves_array = []
    old_x, old_y = @position
    move_dirs.each do |dx, dy|
      new_x, new_y = old_x + dx, old_y + dy
      next unless still_on_board?(new_x, new_y)
      
      square = @board[[new_x, new_y]]
      
      if square.nil? || square.color != self.color
        #if it's empty or occupied by an emeny
        moves_array << [new_x, new_y] 
      end
    end
    moves_array
  end
end