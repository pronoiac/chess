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