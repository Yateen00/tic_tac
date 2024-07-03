class Game
  def initialize
    @canvas = Canvas.new
    @player = Player.new(@canvas)
    @ai = AI.new(@canvas)
    @current_turn = :player
    @player_score = 0
    @ai_score = 0
  end

  def new_game
    @canvas.reset_board
    @player.choose_symbol
    ranges = [*("A".."Z"), *("0".."9")].flatten.join
    symbols = "!@#$%^&*()-_=+[]{}|;:',.<>/?`~}#{ranges}".delete(@player.symbol.to_s)
    @ai.symbol = symbols.split("").sample
    @canvas.set_symbols(@player.symbol, @ai.symbol)
    @canvas.display_board
    play_game
  end

  private

  def play_game
    loop do
      if @current_turn == :player
        @player.make_move
        @current_turn = :ai
      else
        @ai.make_move
        @current_turn = :player
      end
      @canvas.display_board
      break if game_over?
    end
  end

  def game_over?
    winner = @canvas.check_winner
    if winner
      puts "#{winner} wins!"
      @player_score += 1 if winner == :player
      @ai_score += 1 if winner == :ai
      true
    elsif @canvas.draw?
      puts "It's a draw!"
      true
    else
      false
    end
  end
end

class Player
  attr_accessor :symbol

  def initialize(canvas)
    @canvas = canvas
    @symbol = ""
  end

  def choose_symbol
    puts "Choose any 1 character:"
    self.symbol = gets.chomp.upcase[0]
  end

  def make_move
    puts "\nEnter your move (row,column):"
    move = gets.chomp.split(",").map(&:to_i)
    unless @canvas.available_moves.include?(move)
      puts "Invalid move. Try again."
      return make_move
    end
    @canvas.fill_cell(move, symbol)
  end
end

class AI
  attr_accessor :symbol

  def initialize(canvas)
    @canvas = canvas
    @symbol = ""
  end

  def make_move
    move = @canvas.available_moves.sample
    puts "\nAI's turn"
    @canvas.fill_cell(move, symbol)
  end
end

class Canvas
  def initialize
    reset_board
    @player_symbol = nil
    @ai_symbol = nil
  end

  def set_symbols(player_symbol, ai_symbol)
    @player_symbol = player_symbol
    @ai_symbol = ai_symbol
  end

  def reset_board
    @board = Array.new(3) { Array.new(3, " ") }
  end

  def display_board
    puts @board.map { |row| row.join(" | ") }.join("\n--+---+--\n")
  end

  def fill_cell(move, symbol)
    row = move[0]
    col = move[1]
    @board[row - 1][col - 1] = symbol
  end

  def available_moves
    moves = []
    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        moves << [row_index, col_index] if cell == " "
      end
    end
    moves
  end

  def check_winner
    # Implement win condition checks (rows, columns, diagonals)
    # Return 'Player' or 'AI' if a winner is found, else nil
    debug
    symbol = check_column_match || check_row_match || check_diagonal_match
    if symbol == @player_symbol
      :player
    elsif symbol == @ai_symbol
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

  def draw?
    @board.all? { |row| row.none?(" ") }
  end
end

def test
  game = Game.new
  game.new_game
end

test
