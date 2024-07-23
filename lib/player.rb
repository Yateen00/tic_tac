class Player
  attr_accessor :symbol, :canvas, :score, :name

  def initialize(canvas, name = "")
    @canvas = canvas
    @symbol = ""
    @score = 0
    @name = name
  end

  def reset_score
    @score = 0
  end

  def choose_symbol
    raise NotImplementedError
  end

  def make_move
    raise NotImplementedError
  end

  def get_random_char(exclude = "")
    # Define a string that includes lowercase letters, uppercase letters, digits, and a selection of symbols
    characters = ("0".."9").to_a + ("a".."z").to_a + ("A".."Z").to_a +
                 ["!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "+", "=",
                  "{", "}", "[", "]", "|", ":", ";", "<", ">", ",", ".", "?", "/"]
    random_character = ""
    # Use sample to get a random character from the array
    random_character = characters.sample while exclude.include?(random_character)
    random_character
  end

  def assign_symbol(symbol = "", exclude = "")
    symbol = get_random_char(exclude) if symbol.empty?
    return false if exclude.include?(symbol) || symbol.length > 1

    @symbol = symbol
    true
  end
end
