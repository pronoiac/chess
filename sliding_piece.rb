class SlidingPiece < Piece
  def moves
    moves_array = []
    move_dirs.each do |dx, dy|
      old_x, old_y = @position
      while true
        new_x, new_y = old_x + dx, old_y + dy
        break unless still_on_board?(new_x, new_y)
        square = @board[[new_x, new_y]]
        unless square.nil?
          if square.color == self.color
            break
          else 
            moves_array << [new_x, new_y]
            break
          end
        end        
        moves_array << [new_x, new_y]
        old_x, old_y = new_x, new_y
      end
    end
    moves_array  
  end
end