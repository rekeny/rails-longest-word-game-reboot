require 'open-uri'
require 'json'

class GamesController < ApplicationController
  VOWELS = %w(A E I O U)
  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @letters = params[:letters].downcase
    @include = compare_strings(params[:word])
    @english = check_english(params[:word])
  end

  private
  def compare_strings(word)
    word_array = word.downcase.chars
    # letters_array = Array.new
    # letters_array << @letters
    word_array.all? { |letter| word.count(letter) <= @letters.count(letter) }
  end

  def check_english(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    word = JSON.parse(open(url).read)
    word['found']
  end
end
