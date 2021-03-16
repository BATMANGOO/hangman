def intro(arr, incorrect_letters, mistakes)
  puts ''
  puts 'welcome to hangman! In this game you the player will have have 6 tries to guess the correct word.'
  puts "Failure to do so will result in getting hanged (ouch!). Goodluck!\n\n"
  puts "Press '1' so save your game"
  puts "Press '2' to load your save\n\n"

  puts "You are looking for a #{arr.length} letter word!\n\n"

  score(arr, incorrect_letters, mistakes)
end

def score(arr, incorrect_letters, mistakes = nil)
  puts "mistakes: #{mistakes} of 6"
  puts "Correct words: #{arr}"
  puts "Incorrect words: #{incorrect_letters}"
end

