require_relative "lib/game"
def tic_tac_toe
  game = Game.new
  game.play
end

def connect_four
  game = Game.new(7, 4)
  game.play
end

def custom(dimension, match_count)
  game = Game.new(dimension, match_count)
  game.play
end

connect_four
