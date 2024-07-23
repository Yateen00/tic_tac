require_relative "canvas"
require_relative "human"
require_relative "computer"
require_relative "win_conditions"
class Game
  attr_accessor :player1, :player2, :canvas, :matchs_to_win

  def initialize(dimension = 3, match_count = 3)
    @canvas = Canvas.new(dimension)
    @player1 = create_player(1)
    player1.choose_symbol
    puts "#{player1.name} chose #{player1.symbol}"
    @player2 = create_player(2)
    player2.choose_symbol(player1.symbol)
    puts "#{player2.name} chose #{player2.symbol}"
    puts "The game is on!"
    @matchs_to_win = match_count
  end

  def create_player(player_number)
    loop do
      puts "Is player #{player_number} a human or computer? (h/c)"
      player_type = gets.chomp.downcase
      case player_type
      when "h"
        puts "Player #{player_number}, what is your name?"
        name = gets.chomp
        puts "\n"
        return Human.new(@canvas, name)
      when "c"
        puts "\n"
        return Computer.new(@canvas, "Computer #{player_number}")
      else
        puts "Invalid input. Please enter 'h' for human or 'c' for computer."
      end
    end
  end

  def reset_canvas
    @canvas.reset_canvas
  end

  def reset_score
    @player1.reset_score
    @player2.reset_score
  end

  def play
    loop do
      play_round
      break unless play_again?
    end
  end

  def play_again?
    puts "Do you want to play again? (y/n)"
    return true if gets.chomp.downcase == "y"

    false
  end

  def play_round
    reset_canvas
    loop do
      @player1.make_move
      break if game_over?

      @player2.make_move
      break if game_over?
    end
  end

  def game_over?
    winner = get_winner
    if !winner.nil?
      puts "Congratulations! #{winner.name} wins!"
      winner.score += 1
      return true
    elsif @canvas.unfilled_cells.empty?
      puts "It's a tie!"
      return true
    end
    false
  end

  def get_winner
    symbol = row_match_symbol || column_match_symbol || diagonal_match_symbol
    if symbol == @player1.symbol
      return @player1
    elsif symbol == @player2.symbol
      return @player2
    end

    nil
  end
  include WinConditions
end

# column alternate
# (0..2).each do |i|
# symbol = @board[0][i]
# winner = symbol
# next if symbol == " "

# (1..2).each do |j|
#   if @board[j][i] != symbol
#     winner = nil
#     break
#   end
# end
# return winner unless winner.nil?
# end
# nil
