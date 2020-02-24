require 'open-uri'

class GamesController < ApplicationController
  # LETTERS = Array.new(0)
  # 10.times do
  #   LETTERS << ('A'..'Z').to_a.sample
  # end

  def new
    @letters = Array.new(0)
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    @answer = params[:answer]
    @letters = params[:letters].upcase.chars
    @data = parse_data
    @check = validity(@answer.upcase.chars, @letters)
  end

  def parse_data
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    JSON.parse(open(url).read)
  end

  def validity(answer, letters)
    answer_hash = Hash.new(0)
    letters_hash = Hash.new(0)

    answer.each { |letter| answer_hash[letter.to_sym] += 1 }
    letters.each { |letter| letters_hash[letter.to_sym] += 1 }

    answer_hash.all? { |letter, _| answer_hash[letter] <= letters_hash[letter] }
  end
end
