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
 
def testing_moves
  b = Board.new
  b.populate_board
  
  puts "testing knight move (0, 1) to (2, 0)"
  b.move([0, 1], [2, 0])
  p b

  puts "testing pawn move (1, 4) to (3, 4)"
  b.move([1, 4], [3, 4])
  p b
end

def testing_check
  b = Board.new
  b.populate_board
  puts "testing check (also checkmate) - \n f2 -> f3, e7 -> e5, g2 -> g4, d8 -> h4"
  b.move([6, 4], [4, 4])
  puts "made move. in check / checkmate? #{b.in_check?(:black)} #{b.checkmate?(:black)}"
  puts "valid moves: "
  puts 
  b.move([7, 3], [5, 5])
  puts "made move. in check / checkmate? #{b.in_check?(:black)} #{b.checkmate?(:black)}"
  b.move([7, 5], [4, 2])
  puts "made move. in check / checkmate? #{b.in_check?(:black)} #{b.checkmate?(:black)}"
  b.move([5, 5], [1, 5])
  puts "made move. in check / checkmate? #{b.in_check?(:black)} #{b.checkmate?(:black)}"
  p b
  #p b.in_check?(:black)
  
  puts "in checkmate? "
  puts b.checkmate?(:black)
  
  
  b = Board.new
  b.populate_board
  puts b.display_board
  puts "now, check but not checkmate. pawn, (1, 3) -> (3, 3)"
  puts "testing check (also checkmate) - \n f2 -> f3, e7 -> e5, g2 -> g4, d8 -> h4"
  b.move([6, 4], [4, 4])
  puts "made move. in check / checkmate? #{b.in_check?(:black)} #{b.checkmate?(:black)}"

  #b.move([0, 6], [2, 7])
  puts "made move. in check / checkmate? #{b.in_check?(:black)} #{b.checkmate?(:black)}"
puts b.display_board
  b.move([7, 3], [5, 5])
  puts "made move. in check / checkmate? #{b.in_check?(:black)} #{b.checkmate?(:black)}"
  b.move([7, 5], [4, 2])
  puts "made move. in check / checkmate? #{b.in_check?(:black)} #{b.checkmate?(:black)}"
  b.move([5, 5], [1, 5])
  puts "made move. in check / checkmate? #{b.in_check?(:black)} #{b.checkmate?(:black)}"
  # puts b[[2,7]].class
 #  p b[[2,7]].moves
 #  p b[[2,7]].valid_moves
  puts b.display_board 
end

# testing
# testing_moves
# testing_check
