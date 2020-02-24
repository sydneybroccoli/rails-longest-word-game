require 'open-uri'

class GamesController < ApplicationController
  URL = 'https://wagon-dictionary.herokuapp.com/'

  VOWELS = %w(A E I O U)
  CONSONANTS = ('A'..'Z').to_a - VOWELS

  def new
    @letters = Array.new(0)
    5.times do
      @letters << VOWELS.sample
      @letters << CONSONANTS.sample
    end
  end

  def score
    letters = params[:letters].upcase.chars
    time = Time.now - Time.parse(params[:start_time])
    @output = {
      answer: params[:answer],
      letters: letters,
      data: parse_data(params[:answer]),
      validity: validity(params[:answer].upcase.chars, letters),
      score: ((100 / time) + params[:answer].length).round(2)
    }
  end

  private

  def parse_data(query)
    JSON.parse(open("#{URL}#{query}").read)
  end

  def validity(answer, letters)
    answer_hash = Hash.new(0)
    letters_hash = Hash.new(0)

    answer.each { |letter| answer_hash[letter.to_sym] += 1 }
    letters.each { |letter| letters_hash[letter.to_sym] += 1 }

    answer_hash.all? { |letter, _| answer_hash[letter] <= letters_hash[letter] }
  end
end
