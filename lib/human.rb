require_relative "player"
class Human < Player
  def choose_symbol(exclude = "")
    puts "choose a one letter symbol(case sensitive) or press enter for a random symbol"
    @symbol = gets.chomp
    choose_symbol unless assign_symbol(symbol, exclude)
    symbol
  end

  def make_move
    puts "Choose a cell between #{canvas.range_string}:"
    cell = gets.chomp.to_i
    make_move unless @canvas.fill_cell(cell, @symbol)
  end
end
