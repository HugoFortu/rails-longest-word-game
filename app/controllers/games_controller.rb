require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { (65 + rand(26)).chr }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    if included?(@word.upcase, @letters)
      if english_word?(@word)
        @result = "well done"
      else
        @result = "not an english word"
      end
    else
      @result = "not in the grid"
    end
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
