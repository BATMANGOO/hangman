require 'csv'
require_relative 'display'

class Hangman
  include Display
  attr_reader :word
  attr_accessor :arr

  def initialize
    @word = pick_random_line.downcase
    @arr = word_grid(word)
  end

  def play_game
    puts word  # remove this when finished
    incorrect_letters = []
    mistakes = 0
    intro(arr, incorrect_letters, mistakes)
    until mistakes == 6
      input = gets.chomp
      input_result(input, word, arr, incorrect_letters, mistakes)
      score(arr, incorrect_letters, mistakes)
      break unless game_over?(arr)
    end
  end

  private

  def game_over?(arr)
    if arr.include?('_')
      true
    else
      puts 'Game Over!'
    end
  end

  def check_word(input, word, arr, wrong_words, mistakes)
    word_split = word.split('')
    word_split.each_with_index do |val, idx|
      if val == input && arr[idx] == '_'
        arr[idx] = input
      elsif !word.include?(input) || (val == input && arr[idx] != '_')
        wrong_words.push(input)
        mistakes += 1
        return false
      end
    end
    true
  end

  def word_grid(word)
    Array.new(word.length - 1, '_')
  end

  def input_result(input, word, arr, incorrect_letters, mistakes)
    if input == '1'
      save_game
    elsif input == '2'
      load_game
    elsif input.downcase.match(/[a-z]/) && input.length == 1
      check_word(input, word, arr, incorrect_letters, mistakes)
    elsif input.empty? || input.length > 1
      puts 'Please enter one letter'
      input_result(gets.chomp, word, arr, incorrect_letters, mistakes)
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
    CSV.open('saved_game.csv', 'w', write_headers: true, headers: ['word', 'array']) do |hdr|
      data_out = [word, arr]
      hdr << data_out
    end
    puts 'Game Saved!'
  end

  def load_game
    content = CSV.open('saved_game.csv', headers: true, header_converters: :symbol)

    content.each do |row|
      word = row[:word]
      array = row[:array]

      puts word
      puts array
    end
  end
end

game = Hangman.new

game.play_game