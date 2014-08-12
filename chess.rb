require 'debugger'
class Board
  
  def initialize()
    @board = Array.new(8) { Array.new(8) }
  end
  
  def [](pos)
    row, col = pos
    @board[row][col]
  end
  
  def populate_board
    populate_base_row(0, :black)
    populate_base_row(7, :white)
    
    populate_pawn_row(1, :black)
    populate_pawn_row(6, :white)    
  end  
  
  def populate_base_row(row, color)
    @board[row][0] = Rook.new([row, 0], self, color)
    @board[row][1] = Knight.new([row, 1], self, color)
    @board[row][2] = Bishop.new([row, 2], self, color)
    @board[row][3] = Queen.new([row, 3], self, color)
    @board[row][4] = King.new([row, 4], self, color)
    @board[row][5] = Bishop.new([row, 5], self, color)
    @board[row][6] = Knight.new([row, 6], self, color)
    @board[row][7] = Rook.new([row, 7], self, color)
  end
      
  def populate_pawn_row(row, color)
    (0..7).each do |col|
      @board[row][col] = Pawn.new([row, col], self, color)
    end    
  end
      
  def in_check?(color)
  end
  
  def move(start, end_pos)
  end
    
end

class Piece
  attr_reader :position, :board, :color
  
  DIAGONALS = [
    [-1, -1], [+1, -1], 
    [-1, +1], [+1, +1]
  ]

  UP_DOWN = [
            [0, -1],
    [-1, 0],        [+1, 0],
            [0, +1]
  ]
  
  BOTH = DIAGONALS + UP_DOWN
    
  # each piece has type, pos, board, color, moves (which lists valid moves)
  def initialize(position, board, color)
    # type.initialize()
    @position = position
    @board = board
    @color = color
  end
  
  def moves # => returns array of possible moves
  end
  
  def still_on_board?(x, y)
    # new_x, new_y = position
    return false unless x.between?(0, 7) && y.between?(0, 7)
    true
  end
end

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
      next unless square.nil? || square.color == self.color

      # cool? then add to results.
      moves_array << [new_x, new_y] 
    end
    moves_array
  end
end


class Knight < SteppingPiece
  def move_dirs
    KNIGHTS_DELTA  
  end
end

class Bishop < SlidingPiece
  def move_dirs
    DIAGONALS
  end
end

class Rook < SlidingPiece
  def move_dirs
    UP_DOWN  
  end
end

class Queen < SlidingPiece
  def move_dirs
    BOTH
  end
end

class King < SteppingPiece
  def move_dirs
    BOTH
  end
end

class Pawn < SteppingPiece
  def move_dirs
    old_x, old_y = @position
    moves_array = []
    offsets = [ [-1, 0], [-2, 0] ]
    if @color == :black && x == 1
      # moves_array << 
    elsif @color == :white && x == 6
      # add 2 square case
    end
    
  end
end

def testing
  b = Board.new
  b.populate_board
  
  puts "Checking knight's moves (0, 1):"
  kn = Knight.new([1, 0], b, :white)
  p kn.moves

  puts "checking bishop's moves (3, 4):"
  bs = Bishop.new([3, 4], b, :white)
  p bs.moves
  
  puts "checking rook's moves (3, 4):"
  r = Rook.new([3, 4], b, :white)
  p r.moves
  
  puts "checking queen's moves (3, 4):"
  q = Queen.new([3, 4], b, :white)
  p q.moves
  
  puts "checking king's moves (3, 4):"
  k = King.new([3, 4], b, :white)
  p k.moves
  
end

testing
