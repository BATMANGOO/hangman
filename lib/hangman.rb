require_relative "display"

def pick_random_line
  word = File.readlines('word_bank.txt').sample
  if (word.length - 1) < 5 || (word.length - 1) > 12
    pick_random_line
  else
    word
  end
end

def play_word
  word = pick_random_line
  puts word
  puts word.length - 1
  arr = Array.new(word.length - 1, '_')
  p arr
  puts arr.size
end

def play_game 
  intro
  puts play_word.to_s
end

def correct_input(input)
  input.match(/[a-g]ig/) #check if this works
end

play_game