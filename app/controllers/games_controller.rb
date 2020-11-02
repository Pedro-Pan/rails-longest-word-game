class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ("A".."Z").to_a.sample }
  end

  def score
    session[:score] ||= 0
    require 'open-uri'
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    word_verifier = open(url).read
    @word_verified = JSON.parse(word_verifier)
    @letter_included = params[:word].upcase.chars.all? do |letter|
      params[:word].count(letter) <= params["letters"].split('').count(letter)
    end
  end
end

