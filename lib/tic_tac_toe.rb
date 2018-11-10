class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8], # Lower row
    [0,3,6], # Left column
    [1,4,7], # Middle column
    [2,5,8], # Right column
    [0,4,8], # Diagonal starts from top left corner
    [2,4,6]  # Diagonal starts from top right corner
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_index = user_input.to_i
    index = user_index - 1
  end

  def move(index, character = "X")
    valid_move?(index) ? @board[index] = character : false
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    !position_taken?(index) && index.between?(0,8)
  end

  def turn
    puts "Please enter a number (1-9):"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(index)
      token = current_player
      move(index, token)
    else
      turn
    end
    display_board
  end

  def turn_count
    @board.select {|index| index == "X" || index == "O"}.length
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def won?
    winner = []
    WIN_COMBINATIONS.each { |index|
      win_index_1 = index[0]
      win_index_2 = index[1]
      win_index_3 = index[2]
      puts position_1 = @board[win_index_1]
      puts position_2 = @board[win_index_2]
      puts position_3 = @board[win_index_3]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        winner = index
        break
      elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
        winner = index
        break
      end }
     winner == [] ? false : winner
  end

  def full?
    @board.all? {|index| index == "X" || index == "O"}
  end

  def draw?
    !won? && full?
  end

  def over?
    won? || draw?
  end

  def winner
    index = won? ? won?[0] : false
    index ? @board[index] : nil
  end

  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
end
