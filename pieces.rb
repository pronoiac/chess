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