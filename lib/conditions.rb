module Conditions
  def append_wrong_words(input, incorrect_letters)
    incorrect_letters.empty? ? "#{input}" : ", #{input}"
  end

end