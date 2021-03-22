require 'yaml'
require_relative 'display'

class Hangman
  include Display
  attr_reader :word
  attr_accessor :arr, :mistakes, :incorrect_letters

  def initialize
    @word = pick_random_line.downcase
    @arr = word_grid(word)
    @incorrect_letters = []
    @mistakes = 0
  end

  def play_game
    intro(arr, incorrect_letters, mistakes)
    until mistakes == 6
      input = gets.chomp
      input_result(input)
      score(arr, incorrect_letters, mistakes)
      break unless game_over?(arr)
    end
  end

  private

  def game_over?(arr)
    puts 'You Lose!' if mistakes >= 6
    if arr.include?('_')
      true
    else
      puts 'Game Over!'
    end
  end

  def check_word(input)
    word_split = word.split('')
    word_split.each_with_index do |val, idx|
      if val == input && arr[idx] == '_'
        arr[idx] = input
      elsif !word.include?(input) || (val == input && arr[idx] != '_')
        @incorrect_letters.push(input)
        @mistakes += 1
        return false
      end
    end
  end

  def word_grid(word)
    Array.new(word.length - 1, '_')
  end

  def input_result(input)
    if input == '1'
      save_game
    elsif input == '2'
      load_game
    elsif input.downcase.match(/[a-z]/) && input.length == 1
      check_word(input)
    elsif input.empty? || input.length > 1
      puts 'Please enter one letter'
      input_result(gets.chomp)
    end
  end

  def pick_random_line
    word = File.readlines('word_bank.txt').sample
    if (word.length - 1) < 5 || (word.length - 1) > 12
      pick_random_line
    else
      word
    end
  end

  def save_game
    File.open('saved_game.yml', 'w') { |f| YAML.dump([] << self, f) }
    puts 'Game Saved!'
  end

  def load_game
    yaml = YAML.load_file('./saved_game.yml')
    @word = yaml[0].word
    @arr = yaml[0].arr
    @incorrect_letters = yaml[0].incorrect_letters
    @mistakes = yaml[0].mistakes
    puts 'Save Loaded!'
  end
end

game = Hangman.new
game.play_game
