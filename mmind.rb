class Game
  attr_reader :board
  MAX_TURNS = 10
  def initialize(board = Code.random)
    @board = Code.new
    @turns_taken = 0
    @user_guess = ""
    puts "Debug: "
    p @board
  end
  
  def check_guess
    print "You had #{@board.exact_matches(@user_guess)} exact matches"
    puts " and #{@board.near_matches(@user_guess)} near matches"
  end
  
  def play
    puts "You're playing Mastermind."
    puts "The colors are R G B Y O P, with 4 pegs."
    puts "You have up to #{MAX_TURNS} turns"
          
    while @turns_taken < MAX_TURNS
      begin # we'll validate input
        puts "You have #{MAX_TURNS - @turns_taken} turns remaining"
        puts "Enter a guess like BOGY, or in lowercase, poyb."
        read_guess        
        break if win?
        check_guess
        @turns_taken += 1
      rescue InvalidInput => myError
        puts myError.message
        retry
      end
    end
    
    if win?
      puts "You guessed it, in #{@turns_taken} turns."
    else
      puts "You're out of guesses. Good try!"
    end
    
  end
  
  def win?
    @board == @user_guess
  end
  
  def read_guess
    input = gets.chomp
    
    unless input.length == 4
      raise InvalidInput.new "Length of guess must be 4."
    end
      
    @user_guess = Code.parse(input)
    
  end

end

class InvalidInput < StandardError
end

class Code
  COLORS = %w(R G B Y O P)
  
  attr_reader :board
  
  def initialize colors = Code.random
    @board = colors
  end
  
  def ==(guess)
    @board == guess.board
  end
  
  def near_matches guess
    counter = 0
    guess.board.each_with_index do |el, ind|
      counter +=1 if @board.include?(el) && el != @board[ind]
    end
    counter    
  end
  
  def exact_matches guess
    exact = 0
    (0...@board.length).each do |i|
      exact += 1 if @board[i] == guess.board[i]
    end
    exact
  end
  
  def self.parse(input)    
    results = input.split.join.upcase.split('')
    unless results.all? {|letter| COLORS.include?(letter) }
      raise InvalidInput.new("Only use specified colors")
    end
    Code.new results
  end
  
  def self.random
    board =  [] 
    4.times { board << COLORS.sample }
    board
  end
  
  def inspect
    @board
  end
  
end
# /Code


Game.new.play
