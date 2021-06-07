require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score

    @message = ""
      if included?
        if english_word?
          @message = "Congratulation! #{params[:word].upcase} is an English word."
        else
          @message = "Sorry but #{params[:word].upcase}, does not seem to be an english word"
        end
      else
        @message = "Sorry but #{params[:word].upcase} is not in the grid"
      end
  end

  def included?
    params[:word].upcase.chars.all? { |letter| params[:word].upcase.count(letter) <= params[:letters].count(letter) }
  end

  def english_word?
      response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word].upcase}")
      json = JSON.parse(response.read)
      return json['found']
  end
end
