require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = []
    mix_letters = ('A'..'Z').to_a
    10.times do
      @letters << mix_letters.sample
    end
  end

  def score
    @word = params[:input]
    @result = params[:input].chars
    @user_choice = params[:letters].chars
    if @result - @user_choice != []
      @score = "The word #{@word} can t be built out of the original grid"
    elsif @result - @user_choice == [] && dictionary?(params[:input])
      @score = "The word #{@word} is valid according to the grid and is an
         English word"
        else @score = "The word #{@word} is valid according to the grid, but is not
         # a valid English word"

    end
  end

  def dictionary?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = open(url).read
    beers = JSON.parse(user_serialized)
    beers["found"]
  end
end
