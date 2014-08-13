class Board
  
  attr_reader :board
  
  def initialize(pop = true)
    @board = Array.new(8) { Array.new(8) }
    populate_board if pop
  end
  
  def dup
    duped_board = Board.new(false)
    self.list_all_pieces.each do |piece|
      duped_piece = piece.class.new(piece.position.dup, duped_board, piece.color)
      duped_board[piece.position] = duped_piece
    end
    duped_board
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
    old_x, old_y = start
    new_x, new_y = end_pos
    # debugger
    piece = @board[old_x][old_y]
    raise ArgumentError "No piece to move from there" if piece.nil? 
    if piece.moves.include?(end_pos)
      piece.position = end_pos
      
      # update board
      @board[new_x][new_y] = piece
      @board[old_x][old_y] = nil
    else
      raise ArgumentError "Invalid move"
    end
  end
  
  def list_all_pieces
    @board.flatten.compact
  end
  
  def all_pieces_of_color(color)
    list_all_pieces.select { |piece| piece.color == color }
  end
    
  def king_of_color(color)
    all_pieces_of_color(color).select { |piece| piece.is_a?(King) }.first
  end
  
  def opponent_color(color)
    return :black if color == :white
    :white
  end
  
  def in_check?(color)
    debugger
    king_pos = king_of_color(color).position
    moves = all_pieces_of_color(opponent_color(color)).map { |piece| piece.moves }
    p moves
    p king_pos
    moves.include?(king_pos)
  end
    
end