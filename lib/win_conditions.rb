module WinConditions
  def row_match_symbol
    match_count(@canvas.canvas)
  end

  def column_match_symbol
    match_count(@canvas.canvas.transpose)
  end

  def match_count(array2d)
    array2d.each do |array|
      count = 0
      array.each_with_index do |symbol, index| # matchs_to_win
        if symbol == array[index - 1]
          count += 1
        else
          count = 1
        end
        return player1.symbol if count >= matchs_to_win && symbol == player1.symbol
        return player2.symbol if count >= matchs_to_win && symbol == player2.symbol
      end
    end
    nil
  end
  # count continous ones

  def diagonal_match_symbol
    diagonals = left_diagonals + right_diagonals
    match_count(diagonals)
  end

  def left_diagonals
    length = @canvas.dimension
    indexes = Array.new(length) { |i| [0, i] } +
              Array.new(length) { |i| [i, 0] }[1..]
    indexes.map do |row, column|
      sub_array = []
      while row < length && column < length
        sub_array << @canvas.canvas[row][column]
        row += 1
        column += 1
      end
      sub_array
    end
  end

  def right_diagonals
    length = @canvas.dimension
    indexes = Array.new(length) { |i| [0, i] } +
              Array.new(length) { |i| [i, length - 1] }[1..]
    indexes.map do |row, column|
      sub_array = []
      while row.between?(0, length - 1) && column.between?(0, length - 1)
        sub_array << @canvas.canvas[row][column]
        row += 1
        column -= 1
      end
      sub_array
    end
  end

  def debug
    puts "row #{row_match_symbol}"
    puts "column #{column_match_symbol}"
    puts "diagonal #{diagonal_match_symbol}"
  end
end
