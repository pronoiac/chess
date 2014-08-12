class Hangman
  attr_reader :guesser, :hangman
  def initialize(guesser)
    # :cpu or :human? 
    if guesser == :human
      # Simplified for Phase I: 
      # phase 1: :human is always guessing
      @guesser = HumanPlayer.new 
      @hangman = ComputerPlayer.new
    else
      # guesser = :cpu
      @guesser = ComputerPlayer.new
      @hangman = HumanPlayer.new 
    end
    
    @current_board = Array.new []
    @guessed_letters = []
    @guesses_left = 6
    # play #(@guesser, @hangman) 
  end
  
  def play #(guesser, hangman)    
    secret_word_length = hangman.pick_secret_word
    @current_board = Array.new(secret_word_length) { '_' }    
    guesser.receive_secret_length(secret_word_length)
    
    # loop until win? or lose?
    while incomplete? && @guesses_left > 0
      print_status # display status - board, guessed letters
      
      @letter = guesser.guess
      @matches = hangman.check_guess(@letter)
      turn_letters
      guesser.handle_guess_response(@matches)

    end

    if incomplete? 
      puts "Good try!"
    else
      puts "Nice! The word was #{@current_board.join}!"
    end
    
  end # /phase 1
  
  def incomplete?
    @current_board.include? "_"
  end
  
  def turn_letters
    return puts "Already guessed!" if @guessed_letters.include?(@letter)
    @guesses_left -= 1 if @matches.empty?
    @matches.each { |i| @current_board[i] = @letter }
    @guessed_letters << @letter
  end
  
  def print_status
    print "Guessed Letters: "
    puts @guessed_letters.join(' ')
    print "Secret word: "
    puts @current_board.join(' ')
    puts "Guesses left: #{@guesses_left}"
  end
end # /Hangman


class HumanPlayer
  
  def initialize 
    @guessed_letters = []
  end
  
  # player
  def receive_secret_length(length)
    puts "The word is #{length} letters long."
  end
  
  def guess
    puts "Pick one letter."
    @letter = gets.chomp[0]
  end
  
  def handle_guess_response(matches)
    return puts "Already guessed!" if @guessed_letters.include?(@letter)
    # @guesses_left -= 1 if matches.empty?
    # matches.each { |i| @current_board[i] = @letter }
#     @guessed_letters << @letter
  end
  

  # hangman
  def pick_secret_word
    puts "Think of a word"
    puts "Don't tell me the word, just the length"
    choice = 0
    until (5..14).include? choice
      puts "Please choose a number between 5 and 14."
      choice = gets.chomp.to_i 
    end
    @current_board = Array.new(choice) {|i| i }
    choice
  end
  
  def check_guess(letter)
    puts "char numbers:" + @current_board.join(' ')
    puts "Any matches? Enter matches, separated by commas, or 'n' for 'nope':"
    read = gets.chomp
    return [] if read == "n"
    read.split(',').map(&:to_i)
  end
    
  
end # /HumanPlayer

class ComputerPlayer
  # read dictonary. 
  DICTIONARY = File.readlines('dictionary.txt').select {|el| el.length > 5 }.map(&:chomp)

  def initialize
    @guessed_letters = []   
  end
  
  # hangman 
  def pick_secret_word
    @secret_word = DICTIONARY.sample
    puts "psst, the secret word is: #{@secret_word}"
    @secret_word.length
  end
  
  def check_guess(letter)
    # returns an array of the matches. 
    @secret_word.split("").each_index.select { |i| @secret_word[i] == letter }
  end
  
  # player
  def receive_secret_length(length)
    @secret_word_length = length
    @dictionary = DICTIONARY.select { |word| word.length == length}
    puts "Down to #{@dictionary.count} words."
    true
  end
  
  def guess
    @letter = @letter || (("a".."z").to_a - @guessed_letters).sample
    @guessed_letters << @letter
    puts "My guess is: #{@letter}"
    @letter    
  end
  
  def handle_guess_response(matches) 
    # it gets an array of where @letter appeared. 
    filter_dictionary(matches)
    puts "Down to #{@dictionary.count} words."
    @letter = letter_selector
  end  
  
  def filter_dictionary(matches)
    # narrow down @dictionary
    # given matches, an array of where letter appears. 
    # loop i over indexes, 0 ... word length
    (0...@secret_word_length).each do |i|
      # if matches contains i, remove words that don't have letter at index i
      if matches.include? i
        @dictionary.reject!{|word| word[i] != @letter}
      # else remove words that has letter at index i
      else 
        @dictionary.reject!{|word| word[i] == @letter}
      end
    end
  end
  
  def letter_selector
    # most frequent letter found in dictionary
    possible = ("a".."z").to_a - @guessed_letters
    possible.sort_by { |letter| @dictionary.join.count(letter) }.last
  end
end # /ComputerPlayer

puts "Who is the guesser? You (me), or the CPU (cpu)?"
choice = gets.chomp
if choice.downcase.include?('me')
  Hangman.new(:human).play
else
  puts "I guess it's the cpu..."
  Hangman.new(:cpu).play
end
