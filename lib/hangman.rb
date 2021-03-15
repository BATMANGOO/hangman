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

def play_game # reduce logic into helper funtions
  word = pick_random_line
  puts word
  arr = word_grid(word)
  mistakes = 0
  intro # add more dialog towards game progression
  until mistakes == 6
    puts mistakes
    input = correct_input(gets.chomp)
    mistakes += 1 unless check_word(input, word, arr)
    p arr
    break if arr.include?('_') == false
  end
end

def check_word(input, word, arr) # check for bugs
  word_split = word.split('')
  word_split.each_with_index do |val, idx|
    if val == input && arr[idx] == '_'
      arr[idx] = input
    elsif !word.include?(input) || (val == input && arr[idx] != '_')
      return false
    end
  end
  true
end

def correct_input(input)
  if input.downcase.match(/[a-z]/) && input.length == 1
    input
  elsif input.empty? || input.length > 1
    puts 'Please enter one letter'
    correct_input(gets.chomp)
  end
end

play_game