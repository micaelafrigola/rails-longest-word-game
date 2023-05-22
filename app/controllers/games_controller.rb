require 'open-uri'
require 'json'

url = "https://wagon-dictionary.herokuapp.com/zzzz"
user = JSON.parse(URI.open(url).read)
puts "#{user["found"]} - #{user["word"]}"

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @included = included?(params[:word], params[:letters])
    @english_word = validate_english?(params[:word])
  end

private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def validate_english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    json_hash = JSON.parse(URI.open(url).read)
    return json_hash["found"]
  end
end
