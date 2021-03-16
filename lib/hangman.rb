require_relative 'display'

def pick_random_line
  word = File.readlines('word_bank.txt').sample
  if (word.length - 1) < 5 || (word.length - 1) > 12
    pick_random_line
  else
    word
  end
end

def word_grid(word)
  Array.new(word.length - 1, '_')
end

def play_game(word)
  puts word  # remove this when finished
  arr = word_grid(word)
  incorrect_letters = []
  mistakes = 0
  intro(arr, incorrect_letters, mistakes)
  until mistakes == 6
    input = correct_input(gets.chomp)
    mistakes += 1 unless check_word(input, word, arr, incorrect_letters)
    score(arr, incorrect_letters, mistakes)
    break unless game_over?(arr)
  end
end

def game_over?(arr)
  if arr.include?('_')
    true
  else
    puts 'Game Over!'
  end
end

def check_word(input, word, arr, wrong_words)
  word_split = word.split('')
  word_split.each_with_index do |val, idx|
    if val == input && arr[idx] == '_'
      arr[idx] = input
    elsif !word.include?(input) || (val == input && arr[idx] != '_')
      wrong_words.push(input)
      return false
    end
  end
  true
end

def save_game(word, arr)

end

def load_game
  
end

def correct_input(input)
  if input.downcase.match(/[a-z]/) && input.length == 1
    input
  elsif input.empty? || input.length > 1
    puts 'Please enter one letter'
    correct_input(gets.chomp)
  end
end

play_game(pick_random_line)

