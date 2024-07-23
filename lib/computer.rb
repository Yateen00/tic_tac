require_relative "player"
class Computer < Player
  def choose_symbol(exclude = "")
    assign_symbol("", exclude)
    symbol
  end

  def make_move
    cell = @canvas.unfilled_cells.sample
    @canvas.fill_cell(cell, @symbol)
  end
end
