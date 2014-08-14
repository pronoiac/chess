class Piece
  attr_reader :board, :color
  attr_accessor :position
  
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
  
  def inspect
    "#{@color[0]} - #{self.class.to_s[0..1]}"
  end
  
  def valid_moves # => returns array of possible moves
    # cycle through moves, perform move! passing in a duped board
    valid_moves = []
    self.moves.each do |move|
      duped_board = @board.dup
      duped_board.move!(self.position, move)
      next if duped_board.in_check?(self.color)
      valid_moves << move
    end
    valid_moves    
  end
  
  def still_on_board?(x, y)
    # new_x, new_y = position
    return false unless x.between?(0, 7) && y.between?(0, 7)
    true
  end
  
  def render
    return case self
    when Knight
      color == :white ? "♘ " : "♞ "
    when Bishop
      color == :white ? "♗ " : "♝ "
    when Rook
      color == :white ? "♖ " : "♜ "
    when Queen
      color == :white ? "♕ " : "♛ "
    when King
      color == :white ? "♔ " : "♚ "
    when Pawn
      color == :white ? "♙ " : "♟ "  
    end
  end
  
end