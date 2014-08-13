require 'debugger'
require_relative 'board'
require_relative 'piece'
require_relative 'sliding_piece'
require_relative 'stepping_piece'
require_relative 'pawn'
require_relative 'pieces'

def Game
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
  
  puts "checking pawn's moves (3, 4):"
  p = Pawn.new([3, 4], b, :white)
  p p.moves
  
  puts "checking pawn's moves (1, 3):"
  p = Pawn.new([1, 3], b, :black)
  p p.moves
  
  
end

testing
