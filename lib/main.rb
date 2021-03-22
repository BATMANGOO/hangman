require_relative './hangman'

def main
  game = Hangman.new
  game.play_game
end

main
