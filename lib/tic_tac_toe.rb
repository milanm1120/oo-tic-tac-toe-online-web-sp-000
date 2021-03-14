class TicTacToe

  def initialize
    @board = Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2],
  ]

  def display_board             #making the board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)     #saving the players input
    input.to_i - 1              #converting string(input) to an integer
  end

  def move(input, token)
    @board[input] = token       #input to the board with the given token
  end

  def position_taken?(input)                           #checking if a position is available
    if @board[input] == "X" || @board[input] == "O"
      true                                             #position is taken
    else
      false                                            #position is not taken
    end
  end

  def valid_move?(input)
    input.between?(0,8) && !position_taken?(input)  #input to the board is valid AND(&&) position is NOT taken based on input
  end

  def turn_count
    counter = 0                                 #starting a counter
    @board.each do |i|                          #iterating each move
      counter += 1 if i == "X" || i == "O"      #iterating counter if an "x" or "o" is played
    end
    counter
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"            #if the turn_count is divisable by 2, and has no remainder, the value is "X" otherwise its "O"
  end

  def turn
    puts "Pick a position between 1 - 9"
    user_input = gets.chomp
    index = input_to_index(user_input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.detect do |combo|
      @board[combo[0]] == @board[combo[1]] &&
      @board[combo[1]] == @board[combo[2]] &&
      position_taken?(combo[0])
    end
  end

  def full?
    @board.all?{|token| token == "X" || token == "O"}
  end

  def draw?
    !won? && full?
  end

  def over?
    won? || draw?
  end

  def winner
    if winning = won?
      @board[winning_combo.first]
    end
  end

end
