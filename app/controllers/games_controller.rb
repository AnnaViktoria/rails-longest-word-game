require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = params[:letters]
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    word = params[:word]
    grid = params[:grid]
      if real_word?(word) && in_grid?(word, grid)
        @score = "Congratulations! #{word} is a valid English word!"
      elsif real_word?(word)
        @score = "Sorry but #{word} can't be built out of #{grid}"
      else
        @score = "Sorry but #{word} does not seem to be a valid English word.."
      end
  end

  def real_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_word = open(url).read
    user_result = JSON.parse(user_word)
    return user_result['found']
  end

  def real_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_word = open(url).read
    user_result = JSON.parse(user_word)
    return user_result['found']
  end

    def in_grid?(word, grid)
    word.upcase.chars.all? { |char| word.upcase.count(char) <= grid.count(char) }
  end

end
