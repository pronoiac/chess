class Board
  
  attr_reader :board
  
  def initialize(pop = true)
    @board = Array.new(8) { Array.new(8) }
    populate_board if pop
  end
  
  def dup
    Board.new(false)
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
  
  def move(start, end_pos)
  end
  
  def list_all_pieces
    @board.flatten.compact
  end
  
  def color(color)
    list_all_pieces.select { |piece| piece.color == color }
  end
    
  def king_of_color(color)
    color(color).select { |piece| piece.class.is_a?(King) }
  end
  
  def in_check?(color)
    
  end
    
end