# encoding: utf-8
class Knight < SteppingPiece
  def move_dirs
    KNIGHTS_DELTA  
  end
  def to_s
    color == :white ? "♘ " : "♞ "
  end    
end

class Bishop < SlidingPiece
  def move_dirs
    DIAGONALS
  end
  def to_s
    color == :white ? "♗ " : "♝ "
  end
end

class Rook < SlidingPiece
  def move_dirs
    UP_DOWN  
  end
  def to_s
    color == :white ? "♖ " : "♜ "
  end
end

class Queen < SlidingPiece
  def move_dirs
    BOTH
  end
  def to_s
    color == :white ? "♕ " : "♛ "
  end
end

class King < SteppingPiece
  def move_dirs
    BOTH
  end
  def to_s
    color == :white ? "♔ " : "♚ "
  end
end