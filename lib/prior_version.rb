class Game
  def initialize(player_symbol = "", ai_symbol = "")
    @player_symbol = player_symbol
    @ai_symbol = ai_symbol
    reset_board
    @player_score = 0
    @ai_score = 0
  end

  def new_game
    choose_symbol
    reset_board
    generate_board
    winner = :draw
    until @unfilled_cells.empty? || winner == :player || winner == :ai
      if @player_plays_first
        player_turn
        winner = check_winner
        return if winner == :player

        ai_turn
      else
        ai_turn
        winner = check_winner
        return if winner == :ai

        player_turn
      end
      winner = check_winner
    end
    return unless winner == :draw

    puts "It's a draw!"
  end

  private

  # utility methods
  def reset_board
    @board = Array.new(3) { Array.new(3, " ") }
    @unfilled_cells = (1..9).to_a
    @player_plays_first = rand(2) == 1
  end

  def reset_score
    @player_score = 0
    @ai_score = 0
  end

  def choose_symbol
    return unless @player_symbol == ""

    puts "Choose your symbol (X or O):"
    @player_symbol = gets.chomp.capitalize
    @ai_symbol = @player_symbol == "X" ? "O" : "X"
  end

  def generate_board
    puts @board.map { |row|
           row.join(" | ")
         }.join("\n--+---+--\n")
  end

  # verifier methods
  def check_winner
    debug
    symbol = check_column_match || check_row_match || check_diagonal_match
    if symbol == @player_symbol
      puts "You win!"
      @player_score += 1
      :player
    elsif symbol == @ai_symbol
      puts "AI wins!"
      @ai_score += 1
      :ai
    end
  end

  def debug
    puts "row #{check_row_match}"
    puts "column #{check_column_match}"
    puts "diagonal #{check_diagonal_match}"
  end

  def check_row_match
    3.times do |i|
      arr = @board[i].uniq
      return arr[0] if arr.length == 1 && arr[0] != " "
    end

    nil
  end

  def check_column_match
    (0..2).each do |i|
      symbol = @board[0][i]
      winner = symbol
      next if symbol == " "

      (1..2).each do |j|
        if @board[j][i] != symbol
          winner = nil
          break
        end
      end
      return winner unless winner.nil?
    end
    nil
  end

  def check_diagonal_match
    symbol = @board[1][1]
    3.times do |i|
      return nil unless @board[i][i] == symbol || @board[i][2 - i] == symbol
    end
    symbol
  end

  # turn methods
  def ai_turn
    return if @unfilled_cells.empty?

    puts "\nAI's turn"
    move = @unfilled_cells.sample
    fill_cell(move, @ai_symbol)
  end

  def player_turn
    return if @unfilled_cells.empty?

    puts "\nEnter your move (1-9):"
    move = gets.chomp.to_i
    unless @unfilled_cells.include?(move)
      puts "Invalid move. Try again."
      return player_turn
    end
    fill_cell(move, @player_symbol)
  end

  def fill_cell(move, symbol)
    column = (move - 1) % 3
    row = (move - 1) / 3
    @board[row][column] = symbol
    @unfilled_cells.delete(move)
    generate_board

    # move/3 gives 0,0,1,1,1,2,2,2,3 so -1 to move series back by one
    # move%3 gives 1,2,0,1,2,0,1,2,0 so to move series ahead(map 1 to 0),
    # add 2 or subract -1(as 2-3=-1)
  end
end

def test
  game = Game.new("X", "O")
  game.new_game
end

p symbols.split("").sample
test
