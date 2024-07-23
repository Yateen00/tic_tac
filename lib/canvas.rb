class Canvas
  attr_accessor :canvas, :unfilled_cells, :dimension

  def initialize(dimension)
    @dimension = dimension
    reset_canvas
  end

  def range_string
    "1-#{canvas.dimension**2}"
  end

  def generate_board
    puts @canvas.map { |row|
           row.join(" | ")
         }.join("\n--#{'+---' * (dimension - 2)}+--\n").concat("\n\n")
  end

  def reset_canvas
    @canvas = Array.new(dimension) { Array.new(dimension, " ") }
    @unfilled_cells = (1..dimension**2).to_a
  end

  def fill_cell(move, symbol)
    return false unless @unfilled_cells.include?(move)

    column = (move - 1) % dimension
    row = (move - 1) / dimension
    @canvas[row][column] = symbol
    @unfilled_cells.delete(move)
    generate_board
    true
    # move/3 gives 0,0,1,1,1,2,2,2,3 so -1 to move series back by one
    # move%3 gives 1,2,0,1,2,0,1,2,0 so to move series ahead(map 1 to 0),
    # add 2 or subract -1(as 2-3=-1)
  end
end
